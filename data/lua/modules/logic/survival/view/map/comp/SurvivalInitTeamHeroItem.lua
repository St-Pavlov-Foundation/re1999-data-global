-- chunkname: @modules/logic/survival/view/map/comp/SurvivalInitTeamHeroItem.lua

module("modules.logic.survival.view.map.comp.SurvivalInitTeamHeroItem", package.seeall)

local SurvivalInitTeamHeroItem = class("SurvivalInitTeamHeroItem", LuaCompBase)

function SurvivalInitTeamHeroItem:init(go)
	self.go = go
	self._heroAnim = gohelper.findChildAnim(go, "#go_HaveHero")
	self._goHeroRoot = gohelper.findChild(go, "#go_HaveHero")
	self._goEmpty = gohelper.findChild(go, "#go_Empty")
	self._goLock = gohelper.findChild(go, "#go_Locked")
	self._goNew = gohelper.findChild(go, "#go_New")
	self._goAssit = gohelper.findChild(self._goHeroRoot, "assit")

	local heroGo = gohelper.findChild(self._goHeroRoot, "hero")

	self._heroItem = IconMgr.instance:getCommonHeroItem(heroGo)

	self._heroItem:setStyle_CharacterBackpack()
	self._heroItem:hideFavor(true)

	self._clickThis = gohelper.getClick(self.go)

	gohelper.setActive(self._goLock, false)

	self._healthPart = MonoHelper.addNoUpdateLuaComOnceToGo(self._goHeroRoot, SurvivalHeroHealthPart)
end

function SurvivalInitTeamHeroItem:setIndex(index)
	self._index = index
end

function SurvivalInitTeamHeroItem:setParentView(view)
	self._teamView = view
end

function SurvivalInitTeamHeroItem:addEventListeners()
	self._clickThis:AddClickListener(self._onClickThis, self)
end

function SurvivalInitTeamHeroItem:removeEventListeners()
	self._clickThis:RemoveClickListener()
end

function SurvivalInitTeamHeroItem:getHeroMo()
	return self._heroMO
end

function SurvivalInitTeamHeroItem:onUpdateMO(mo)
	self._heroMO = mo

	local hasHero = self._heroMO ~= nil

	gohelper.setActive(self._goEmpty, not hasHero)
	gohelper.setActive(self._goHeroRoot, hasHero)

	if hasHero then
		self._heroItem:onUpdateMO(self._heroMO)
		self._heroItem:setNewShow(false)

		local lv = SurvivalBalanceHelper.getHeroBalanceLv(self._heroMO.heroId)

		if lv > self._heroMO.level then
			self._heroItem:setBalanceLv(lv)
		end

		self._healthPart:setHeroId(mo.heroId)
		self._heroItem.rootAnim:Play("idle", 0, 0)
	end
end

function SurvivalInitTeamHeroItem:setTrialValue(value)
	self._isTrial = value

	gohelper.setActive(self._goAssit, value)
end

function SurvivalInitTeamHeroItem:setIsLock(value)
	self._isLock = value

	if value then
		gohelper.setActive(self._goLock, true)
		gohelper.setActive(self._goHeroRoot, false)
		gohelper.setActive(self._goEmpty, false)
	end
end

function SurvivalInitTeamHeroItem:setNew(isShow)
	gohelper.setActive(self._goNew, isShow)
end

function SurvivalInitTeamHeroItem:showSelectEffect()
	self._heroAnim:Play("open", 0, 0)
end

function SurvivalInitTeamHeroItem:_onClickThis()
	if self._isTrial or self._isLock then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	SurvivalMapModel.instance:getInitGroup().curClickHeroIndex = self._index

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	SurvivalMapModel.instance:getInitGroup():initHeroList()
	ViewMgr.instance:openView(ViewName.SurvivalInitHeroSelectView)
end

function SurvivalInitTeamHeroItem:onDestroy()
	self._teamView = nil
end

return SurvivalInitTeamHeroItem
