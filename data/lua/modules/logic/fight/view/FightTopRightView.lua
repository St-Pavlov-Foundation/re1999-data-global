-- chunkname: @modules/logic/fight/view/FightTopRightView.lua

module("modules.logic.fight.view.FightTopRightView", package.seeall)

local FightTopRightView = class("FightTopRightView", FightBaseView)

function FightTopRightView:onInitView()
	self.topRightBtnRoot = gohelper.findChild(self.viewGO, "root/btns")
end

function FightTopRightView:addEvents()
	return
end

function FightTopRightView:removeEvents()
	return
end

function FightTopRightView:onOpen()
	self:checkAddSurvivalBtn()
	self:com_openSubView(FightAutoBtnView, gohelper.findChild(self.topRightBtnRoot, "btnAuto"))
end

function FightTopRightView:checkAddSurvivalBtn()
	local isSurvival = FightDataHelper.fieldMgr:isShelter() or FightDataHelper.fieldMgr:isSurvival()

	if not isSurvival then
		return
	end

	local url = "ui/viewres/fight/fightsurvivalbagbtnview.prefab"

	self.survivalBtnLoader = PrefabInstantiate.Create(self.topRightBtnRoot)

	self.survivalBtnLoader:startLoad(url, self.onSurvivalBtnLoaded, self)
end

function FightTopRightView:onSurvivalBtnLoaded()
	local btnGo = self.survivalBtnLoader:getInstGO()

	gohelper.setAsFirstSibling(btnGo)

	self.survivalClick = gohelper.getClickWithDefaultAudio(btnGo)

	self.survivalClick:AddClickListener(self.onClickCollection, self)
end

function FightTopRightView:onClickCollection()
	ViewMgr.instance:openView(ViewName.SurvivalEquipOverView)
end

function FightTopRightView:onClose()
	if self.survivalBtnLoader then
		self.survivalBtnLoader:dispose()

		self.survivalBtnLoader = nil
	end

	if self.survivalClick then
		self.survivalClick:RemoveClickListener()

		self.survivalClick = nil
	end
end

function FightTopRightView:onDestroyView()
	return
end

return FightTopRightView
