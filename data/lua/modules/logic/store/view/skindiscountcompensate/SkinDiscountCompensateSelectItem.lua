-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinDiscountCompensateSelectItem.lua

module("modules.logic.store.view.skindiscountcompensate.SkinDiscountCompensateSelectItem", package.seeall)

local SkinDiscountCompensateSelectItem = class("SkinDiscountCompensateSelectItem", ListScrollCellExtend)

function SkinDiscountCompensateSelectItem:onInitView()
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._btnView = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_View")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._simagesign = gohelper.findChildSingleImage(self.viewGO, "#simage_sign")
	self._txtskinname = gohelper.findChildText(self.viewGO, "#txt_skinname")
	self._txtname = gohelper.findChildText(self.viewGO, "#txt_skinname/#txt_name")
	self._goGet = gohelper.findChild(self.viewGO, "#go_Get")
	self._simageprop = gohelper.findChildSingleImage(self.viewGO, "#go_Get/#simage_prop")
	self._btnViewMask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Get/#btn_ViewMask")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._goGarment = gohelper.findChild(self.viewGO, "#go_Garment")
	self._goAdvance = gohelper.findChild(self.viewGO, "#go_Advance")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SkinDiscountCompensateSelectItem:addEvents()
	self._btnclick:AddClickListener(self._btnViewOnClick, self)
	self._btnViewMask:AddClickListener(self.onLongPressClick, self)
	self._btnView:AddClickListener(self.onLongPressClick, self)

	self.longPress = SLFramework.UGUI.UILongPressListener.Get(self._btnclick.gameObject)

	self.longPress:SetLongPressTime({
		0.4,
		99999
	})
	self.longPress:AddLongPressListener(self.onLongPressClick, self)
end

function SkinDiscountCompensateSelectItem:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnViewMask:RemoveClickListener()
	self._btnView:RemoveClickListener()
	self.longPress:RemoveLongPressListener()
end

function SkinDiscountCompensateSelectItem:_btnViewOnClick()
	local skinId = self.mo.id

	StoreController.instance:dispatchEvent(StoreEvent.DecorateSkinSelectItemClick, skinId, self.mo.index)
end

function SkinDiscountCompensateSelectItem:onLongPressClick()
	local skinId = self.mo.id
	local param = {}

	param.isShowHomeBtn = false
	param.skinId = skinId

	CharacterController.instance:openCharacterSkinTipView(param)
end

function SkinDiscountCompensateSelectItem:_editableInitView()
	self._txtNum = gohelper.findChildTextMesh(self.viewGO, "#go_Get/txt_Num")
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._gotAnimator = gohelper.findChildComponent(self.viewGO, "#go_Get", gohelper.Type_Animator)
end

function SkinDiscountCompensateSelectItem:_editableAddEvents()
	return
end

function SkinDiscountCompensateSelectItem:_editableRemoveEvents()
	return
end

function SkinDiscountCompensateSelectItem:onUpdateMO(mo)
	if mo == nil or mo.id == nil then
		return
	end

	self.mo = mo

	local skinId = self.mo.id
	local skinConfig = SkinConfig.instance:getSkinCo(skinId)
	local heroConfig = HeroConfig.instance:getHeroCO(skinConfig.characterId)

	self._txtname.text = heroConfig.name
	self._txtskinname.text = skinConfig.name

	local haveSkin = HeroModel.instance:checkHasSkin(skinId)

	gohelper.setActive(self._goGet, haveSkin)
	self._simageicon:LoadImage(ResUrl.getStoreSkin(skinId))

	self.haveSkin = haveSkin

	if haveSkin then
		local compensateParam = string.splitToNumber(skinConfig.compensate, "#")
		local num = compensateParam and compensateParam[3] or 0

		self._txtNum.text = tostring(num)
	end

	self:refreshGotAnim(haveSkin)

	local isAdvanced = self.mo.itemId == StoreEnum.V3a3_SkinDiscountAdvancedItemId

	gohelper.setActive(self._goGarment, not isAdvanced)
	gohelper.setActive(self._goAdvance, isAdvanced)
end

function SkinDiscountCompensateSelectItem:getAnimator()
	return self._animator
end

function SkinDiscountCompensateSelectItem:onSelect(isSelect)
	gohelper.setActive(self._goSelected, isSelect)
end

SkinDiscountCompensateSelectItem.GotAnimTime = 4

function SkinDiscountCompensateSelectItem:refreshGotAnim(isGot)
	local animName = isGot and "got" or "idle"
	local normalizeTime = 0

	if isGot then
		local referenceTime = SkinDiscountCompensateListModel.instance:getReferenceTime() or 0
		local offsetTime = UnityEngine.Time.timeSinceLevelLoad - referenceTime
		local animTime = offsetTime % SkinDiscountCompensateSelectItem.GotAnimTime

		if animTime > 0 then
			normalizeTime = animTime / SkinDiscountCompensateSelectItem.GotAnimTime
		end
	end

	self._gotAnimator:Play(animName, 0, normalizeTime)
end

function SkinDiscountCompensateSelectItem:onDestroyView()
	self._simageicon:UnLoadImage()
end

return SkinDiscountCompensateSelectItem
