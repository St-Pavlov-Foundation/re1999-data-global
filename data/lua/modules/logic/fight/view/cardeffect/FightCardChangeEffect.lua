-- chunkname: @modules/logic/fight/view/cardeffect/FightCardChangeEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardChangeEffect", package.seeall)

local FightCardChangeEffect = class("FightCardChangeEffect", BaseWork)

function FightCardChangeEffect:onStart(context)
	FightCardChangeEffect.super.onStart(self, context)

	self._paramDict = {}

	self:_playEffects()
	TaskDispatcher.runDelay(self._delayDone, self, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function FightCardChangeEffect:_playEffects()
	self._effectGOList = {}
	self._effectLoaderList = {}

	local cardItem = self.context.cardItem

	self._entityId = self.context.entityId
	self._skillId = self.context.skillId
	self._changeFailType = self.context.failType

	local oldCardLv = self.context.oldCardLevel
	local newCardLevel = self.context.newCardLevel
	local cardItemGO = cardItem.go
	local changeEffectGO = gohelper.create2d(cardItemGO, "lvChangeEffect")
	local effectLoader = PrefabInstantiate.Create(changeEffectGO)

	self._paramDict[effectLoader] = {
		newCardLevel = newCardLevel,
		oldCardLv = oldCardLv
	}

	local effectPath

	if self._changeFailType then
		effectPath = self._changeFailType == FightEnum.CardRankChangeFail.UpFail and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath
	else
		effectPath = oldCardLv < newCardLevel and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath
	end

	effectLoader:startLoad(effectPath, self._onLvEffectLoaded, self)

	local animPath

	if self._changeFailType then
		animPath = self._changeFailType == FightEnum.CardRankChangeFail.UpFail and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath
	else
		animPath = oldCardLv < newCardLevel and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath
	end

	local animLoader = MultiAbLoader.New()

	self._paramDict[animLoader] = {
		newCardLevel = newCardLevel,
		oldCardLv = oldCardLv,
		cardItem = cardItem
	}

	animLoader:addPath(animPath)
	animLoader:startLoad(self._onLvAnimLoaded, self)

	self._animLoaderList = self._animLoaderList or {}

	table.insert(self._animLoaderList, animLoader)
	table.insert(self._effectGOList, changeEffectGO)
	table.insert(self._effectLoaderList, effectLoader)
end

function FightCardChangeEffect:_onLvEffectLoaded(effectLoader)
	gohelper.onceAddComponent(effectLoader:getInstGO(), typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

	local param = self._paramDict[effectLoader]
	local newCardLevel = param.newCardLevel
	local oldCardLv = param.oldCardLv
	local isBigSkill = FightCardDataHelper.isBigSkill(self._skillId)

	if lua_skill_next.configDict[self._skillId] then
		isBigSkill = false
	end

	local gameObject = effectLoader:getInstGO()
	local normalObj = gohelper.findChild(gameObject, "#card/normal_effect")
	local uniqueObj = gohelper.findChild(gameObject, "#card/ultimate_effect")

	gohelper.setActive(normalObj, not isBigSkill)
	gohelper.setActive(uniqueObj, isBigSkill)

	local starRoot = gohelper.findChild(gameObject, "#star").transform
	local starChildCount = starRoot.childCount
	local starName = oldCardLv .. "_" .. newCardLevel

	for i = 0, starChildCount - 1 do
		local star = starRoot:GetChild(i)

		if star then
			gohelper.setActive(star.gameObject, star.name == starName)
		end
	end
end

function FightCardChangeEffect:_onLvAnimLoaded(animLoader)
	local param = self._paramDict[animLoader]
	local newCardLevel = param.newCardLevel
	local oldCardLv = param.oldCardLv
	local cardItem = param.cardItem
	local cardGO = cardItem.go

	gohelper.setActive(gohelper.findChild(cardGO, "star/star1"), newCardLevel == 1 or oldCardLv == 1)
	gohelper.setActive(gohelper.findChild(cardGO, "star/star2"), newCardLevel == 2 or oldCardLv == 2)
	gohelper.setActive(gohelper.findChild(cardGO, "star/star3"), newCardLevel == 3 or oldCardLv == 3)

	for i, lvGO in ipairs(cardItem._lvGOs) do
		gohelper.setActiveCanvasGroup(lvGO, newCardLevel == i or oldCardLv == i)
	end

	local stateName

	if self._changeFailType then
		-- block empty
	elseif oldCardLv < newCardLevel then
		stateName = "fightcard_rising" .. oldCardLv .. "_" .. newCardLevel
	else
		stateName = "fightcard_escending" .. oldCardLv .. "_" .. newCardLevel
	end

	if stateName then
		local animator = gohelper.onceAddComponent(cardGO, typeof(UnityEngine.Animator))

		animator.runtimeAnimatorController = nil
		animator.runtimeAnimatorController = animLoader:getFirstAssetItem():GetResource()
		animator.speed = FightModel.instance:getUISpeed()
		animator.enabled = true

		animator:Play(stateName, 0, 0)
		animator:Update(0)

		self._animCompList = self._animCompList or {}

		table.insert(self._animCompList, animator)
	end
end

function FightCardChangeEffect:_delayDone()
	self:onDone(true)
end

function FightCardChangeEffect:clearWork()
	TaskDispatcher.cancelTask(self._removeDownEffect, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:_removeDownEffect()
	self:_removeLvAnim()

	self._imgMaskMatDict = nil
	self._imgList = nil
	self._paramDict = nil
end

function FightCardChangeEffect:_removeDownEffect()
	if self._effectLoaderList then
		for _, prefabInstantiate in ipairs(self._effectLoaderList) do
			prefabInstantiate:dispose()
		end
	end

	if self._effectGOList then
		for _, go in ipairs(self._effectGOList) do
			gohelper.destroy(go)
		end
	end

	self._effectGOList = nil
	self._effectLoaderList = nil
end

function FightCardChangeEffect:_removeLvAnim()
	if self._animLoaderList then
		for _, loader in ipairs(self._animLoaderList) do
			loader:dispose()
		end
	end

	self._animLoaderList = nil

	if self._animCompList then
		for _, animComp in ipairs(self._animCompList) do
			if not gohelper.isNil(animComp) then
				animComp.runtimeAnimatorController = nil
			end
		end
	end

	self._animCompList = nil
end

return FightCardChangeEffect
