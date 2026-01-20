-- chunkname: @modules/logic/equip/view/EquipInfoTipsView.lua

module("modules.logic.equip.view.EquipInfoTipsView", package.seeall)

local EquipInfoTipsView = class("EquipInfoTipsView", BaseView)

function EquipInfoTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontainer = gohelper.findChild(self.viewGO, "#go_container")
	self._simageframe = gohelper.findChildSingleImage(self.viewGO, "#go_container/#simage_frame")
	self._txtlv = gohelper.findChildText(self.viewGO, "#go_container/top/name/lv/#txt_lv")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_container/top/name/#txt_name")
	self._goequipitem = gohelper.findChild(self.viewGO, "#go_container/top/#go_equipitem")
	self._simageequipicon = gohelper.findChildSingleImage(self.viewGO, "#go_container/top/#go_equipitem/#simage_equipicon")
	self._imagelock = gohelper.findChildImage(self.viewGO, "#go_container/top/#image_lock")
	self._golockicon = gohelper.findChild(self.viewGO, "#go_container/top/#image_lock/#go_lockicon")
	self._gostrengthenattr = gohelper.findChild(self.viewGO, "#go_container/scroll_view/Viewport/center/attribute/#go_strengthenattr")
	self._gobreakeffect = gohelper.findChild(self.viewGO, "#go_container/scroll_view/Viewport/center/attribute/#go_breakeffect")
	self._gosuitattribute = gohelper.findChild(self.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/attributename/#txt_attributelv")
	self._gosuiteffect = gohelper.findChild(self.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect")
	self._gobaseskill = gohelper.findChild(self.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_baseskill")
	self._txtsuiteffect2 = gohelper.findChildText(self.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_baseskill/suiteffect2/#txt_suiteffect2")
	self._goskillpos = gohelper.findChild(self.viewGO, "#go_container/#go_skillpos")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipInfoTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function EquipInfoTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function EquipInfoTipsView:_btncloseOnClick()
	self:closeThis()
end

function EquipInfoTipsView:onLockClick()
	self.isLock = not self.isLock

	if self.isLock then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Lock)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Unlock)
	end

	EquipRpc.instance:sendEquipLockRequest(self.equipMo.id, self.isLock)
end

function EquipInfoTipsView:onLockChangeReply()
	self:refreshLockUI()
end

function EquipInfoTipsView:_editableInitView()
	self._goSuitEffectItem = gohelper.findChild(self.viewGO, "#go_container/scroll_view/Viewport/center/#go_suitattribute/#go_suiteffect/#go_advanceskill/suiteffect")
	self._goBaseSkillCanvasGroup = self._gobaseskill:GetComponent(gohelper.Type_CanvasGroup)

	gohelper.setActive(self._gostrengthenattr, false)
	gohelper.setActive(self._txtsuiteffect2.gameObject, false)
	self:changeViewGoPosition()

	self.lockClick = gohelper.getClick(self._golockicon)

	self.lockClick:AddClickListener(self.onLockClick, self)

	self.attrGoList = {}
	self._txtDescList = {}
	self.imageBreakIcon = gohelper.findChildImage(self._gobreakeffect, "image_icon")
	self.txtBreakAttrName = gohelper.findChildText(self._gobreakeffect, "txt_name")
	self.txtBreakValue = gohelper.findChildText(self._gobreakeffect, "txt_value")

	self:addEventCb(EquipController.instance, EquipEvent.onEquipLockChange, self.onLockChangeReply, self)
	self._simageframe:LoadImage(ResUrl.getEquipBg("bg_tips.png"))

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function EquipInfoTipsView:onUpdateParam()
	if self.viewParam.equipMo.id == self.equipMo.id then
		return
	end

	self.animatorPlayer:Play(UIAnimationName.Close, function(self)
		self:onOpen()
		self.animatorPlayer:Play(UIAnimationName.Open)
	end, self)
end

function EquipInfoTipsView:onOpen()
	self.equipMo = self.viewParam.equipMo
	self.isLock = self.equipMo.isLock
	self.heroCo = self.viewParam.heroCo

	self:refreshUI()
end

function EquipInfoTipsView:refreshUI()
	self._txtname.text = self.equipMo.config.name
	self._txtlv.text = self.equipMo.level

	self._simageequipicon:LoadImage(ResUrl.getEquipSuit(self.equipMo.config.icon))
	self:refreshLockUI()
	self:refreshAttributeInfo()

	if self.equipMo.config.rare > EquipConfig.instance:getNotShowRefineRare() then
		gohelper.setActive(self._gosuitattribute, true)
		self:refreshSkillInfo()
	else
		gohelper.setActive(self._gosuitattribute, false)
	end
end

function EquipInfoTipsView:refreshLockUI()
	if self.viewParam.notShowLockIcon or EquipHelper.isSpRefineEquip(self.equipMo.config) then
		gohelper.setActive(self._imagelock.gameObject, false)

		return
	end

	UISpriteSetMgr.instance:setEquipSprite(self._imagelock, self.isLock and "bg_tips_suo" or "bg_tips_jiesuo", false)
end

function EquipInfoTipsView:refreshAttributeInfo()
	local attr_dic, attr_list = EquipConfig.instance:getEquipNormalAttr(self.equipMo.config.id, self.equipMo.level, HeroConfig.sortAttrForEquipView)
	local attrGo

	for i, attr in ipairs(attr_list) do
		attrGo = self.attrGoList[i]

		if not attrGo then
			attrGo = self:getUserDataTb_()

			local go = gohelper.cloneInPlace(self._gostrengthenattr, "attr" .. i)
			local bg = gohelper.findChild(go, "bg")
			local icon = gohelper.findChildImage(go, "image_icon")
			local name = gohelper.findChildText(go, "txt_name")
			local attr_value = gohelper.findChildText(go, "txt_value")

			attrGo.go = go
			attrGo.bg = bg
			attrGo.icon = icon
			attrGo.name = name
			attrGo.attr_value = attr_value

			table.insert(self.attrGoList, attrGo)
		end

		local attrConfig = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(attr.attrType))

		UISpriteSetMgr.instance:setCommonSprite(attrGo.icon, "icon_att_" .. attrConfig.id)
		gohelper.setActive(attrGo.bg, i % 2 == 0)

		attrGo.name.text = attrConfig.name
		attrGo.attr_value.text = attr.value

		gohelper.setActive(attrGo.go, true)
	end

	for i = #attr_list + 1, #self.attrGoList do
		gohelper.setActive(self.attrGoList[i].go, false)
	end

	local attrId, value = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(self.equipMo.config, self.equipMo.breakLv)

	if attrId then
		gohelper.setActive(self._gobreakeffect, true)
		UISpriteSetMgr.instance:setCommonSprite(self.imageBreakIcon, "icon_att_" .. attrId)

		self.txtBreakAttrName.text = EquipHelper.getAttrBreakText(attrId)
		self.txtBreakValue.text = EquipHelper.getAttrPercentValueStr(value)

		gohelper.setAsLastSibling(self._gobreakeffect)
	else
		gohelper.setActive(self._gobreakeffect, false)
	end
end

function EquipInfoTipsView:refreshSkillInfo()
	local skillBaseDesList = EquipHelper.getEquipSkillDescList(self.equipMo.config.id, self.equipMo.refineLv, "#975129")

	if #skillBaseDesList == 0 then
		gohelper.setActive(self._gobaseskill, false)
	else
		self._txtattributelv.text = self.equipMo.refineLv

		gohelper.setActive(self._gobaseskill, true)

		local cell, iteminfo, itemGo

		for index, desc in ipairs(skillBaseDesList) do
			cell = self._txtDescList[index]

			if not cell then
				iteminfo = self:getUserDataTb_()
				itemGo = gohelper.cloneInPlace(self._txtsuiteffect2.gameObject, "item_" .. index)
				iteminfo.itemGo = itemGo
				iteminfo.txt = itemGo:GetComponent(gohelper.Type_TextMesh)
				iteminfo.imagepoint = gohelper.findChildImage(itemGo, "#image_point")
				cell = iteminfo

				table.insert(self._txtDescList, cell)
			end

			cell.txt.text = desc

			gohelper.setActive(cell.itemGo, true)
		end

		for i = #skillBaseDesList + 1, #self._txtDescList do
			gohelper.setActive(self._txtDescList[i].itemGo, false)
		end
	end
end

function EquipInfoTipsView:changeViewGoPosition()
	local parentViewGoWeight = recthelper.getWidth(self.viewGO.transform.parent)

	recthelper.setWidth(self.viewGO.transform, parentViewGoWeight / 2 - 100)

	self.viewGO.transform.anchorMin = Vector2(1, 0.5)
	self.viewGO.transform.anchorMax = Vector2(1, 0.5)

	recthelper.setAnchor(self.viewGO.transform, 0, 0)
end

function EquipInfoTipsView:onClose()
	self.lockClick:RemoveClickListener()
end

function EquipInfoTipsView:onDestroyView()
	self._simageframe:UnLoadImage()
	self._simageequipicon:UnLoadImage()
end

return EquipInfoTipsView
