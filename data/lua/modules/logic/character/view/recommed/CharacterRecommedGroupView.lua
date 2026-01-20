-- chunkname: @modules/logic/character/view/recommed/CharacterRecommedGroupView.lua

module("modules.logic.character.view.recommed.CharacterRecommedGroupView", package.seeall)

local CharacterRecommedGroupView = class("CharacterRecommedGroupView", BaseView)

function CharacterRecommedGroupView:onInitView()
	self._gogroup = gohelper.findChild(self.viewGO, "content/group")
	self._imagegroupicon = gohelper.findChildImage(self.viewGO, "content/group/title/icon")
	self._scrollgroup = gohelper.findChildScrollRect(self.viewGO, "content/group/#scroll_group")
	self._goequip = gohelper.findChild(self.viewGO, "content/equip")
	self._imageequipicon = gohelper.findChildImage(self.viewGO, "content/equip/title/icon")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "content/equip/#scroll_equip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterRecommedGroupView:addEvents()
	self:addEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
end

function CharacterRecommedGroupView:removeEvents()
	self:removeEventCb(CharacterRecommedController.instance, CharacterRecommedEvent.OnCutHeroAnimCB, self._refreshHero, self)
end

function CharacterRecommedGroupView:_editableInitView()
	return
end

function CharacterRecommedGroupView:onUpdateParam()
	return
end

function CharacterRecommedGroupView:onOpen()
	self:_refreshHero(self.viewParam.heroId)
	self:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)

	if self._groupItems then
		for _, item in ipairs(self._groupItems) do
			item:playViewAnim(CharacterRecommedEnum.AnimName.Open, 0, 0)
		end
	end
end

function CharacterRecommedGroupView:_refreshHero(heroId)
	if self.heroId and heroId == self.heroId then
		return
	end

	self.heroId = heroId
	self._heroRecommendMO = CharacterRecommedModel.instance:getHeroRecommendMo(heroId)

	local isShowTeam = self._heroRecommendMO:isShowTeam()
	local isShowEquip = self._heroRecommendMO:isShowEquip()

	if isShowTeam then
		self:_refreshGroup()
	end

	if isShowEquip then
		self:_refreshEquip()
	end

	gohelper.setActive(self._gogroup, isShowTeam)
	gohelper.setActive(self._goequip, isShowEquip)
end

function CharacterRecommedGroupView:_refreshGroup()
	if not self._heroRecommendMO then
		return
	end

	local moList = self._heroRecommendMO.teamRec

	if moList then
		if not self._goGroupItem then
			self._goGroupItem = self.viewContainer:getGroupItemRes()
		end

		self._groupItems = {}

		gohelper.CreateObjList(self, self._groupItemCB, moList, self._scrollgroup.content.gameObject, self._goGroupItem, CharacterRecommedGroupItem)
	end
end

function CharacterRecommedGroupView:_groupItemCB(obj, data, index)
	obj:onUpdateMO(data, self.viewContainer, self._heroRecommendMO)
	obj:setIndex(index)

	local isFormCharacterView = self.viewParam.fromView and self.viewParam.fromView == ViewName.CharacterView

	obj:showUseBtn(isFormCharacterView)

	self._groupItems[index] = obj
end

function CharacterRecommedGroupView:_refreshEquip()
	if not self._heroRecommendMO then
		return
	end

	if not self._goequipicon then
		self._goequipicon = self.viewContainer:getEquipIconRes()
	end

	local moList = self._heroRecommendMO.equipRec

	if moList then
		gohelper.CreateObjList(self, self._equipItemCB, moList, self._scrollequip.content.gameObject, self._goequipicon, CharacterRecommedEquipIcon)
	end
end

function CharacterRecommedGroupView:_equipItemCB(obj, data, index)
	obj:onUpdateMO(data)
	obj:setClickCallback(function()
		EquipController.instance:openEquipView({
			equipId = data
		})
	end, self)
end

function CharacterRecommedGroupView:playViewAnim(animName, layer, normalizedTime)
	if not self._viewAnim then
		self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	end

	if self._viewAnim then
		self._viewAnim:Play(animName, layer, normalizedTime)
	end
end

function CharacterRecommedGroupView:onClose()
	return
end

function CharacterRecommedGroupView:onDestroyView()
	return
end

return CharacterRecommedGroupView
