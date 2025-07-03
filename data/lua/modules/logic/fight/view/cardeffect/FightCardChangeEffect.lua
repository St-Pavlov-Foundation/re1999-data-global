module("modules.logic.fight.view.cardeffect.FightCardChangeEffect", package.seeall)

local var_0_0 = class("FightCardChangeEffect", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._paramDict = {}

	arg_1_0:_playEffects()
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function var_0_0._playEffects(arg_2_0)
	arg_2_0._effectGOList = {}
	arg_2_0._effectLoaderList = {}

	local var_2_0 = arg_2_0.context.cardItem

	arg_2_0._entityId = arg_2_0.context.entityId
	arg_2_0._skillId = arg_2_0.context.skillId
	arg_2_0._changeFailType = arg_2_0.context.failType

	local var_2_1 = arg_2_0.context.oldCardLevel
	local var_2_2 = arg_2_0.context.newCardLevel
	local var_2_3 = var_2_0.go
	local var_2_4 = gohelper.create2d(var_2_3, "lvChangeEffect")
	local var_2_5 = PrefabInstantiate.Create(var_2_4)

	arg_2_0._paramDict[var_2_5] = {
		newCardLevel = var_2_2,
		oldCardLv = var_2_1
	}

	local var_2_6

	if arg_2_0._changeFailType then
		var_2_6 = arg_2_0._changeFailType == FightEnum.CardRankChangeFail.UpFail and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath
	else
		var_2_6 = var_2_1 < var_2_2 and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath
	end

	var_2_5:startLoad(var_2_6, arg_2_0._onLvEffectLoaded, arg_2_0)

	local var_2_7

	if arg_2_0._changeFailType then
		var_2_7 = arg_2_0._changeFailType == FightEnum.CardRankChangeFail.UpFail and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath
	else
		var_2_7 = var_2_1 < var_2_2 and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath
	end

	local var_2_8 = MultiAbLoader.New()

	arg_2_0._paramDict[var_2_8] = {
		newCardLevel = var_2_2,
		oldCardLv = var_2_1,
		cardItem = var_2_0
	}

	var_2_8:addPath(var_2_7)
	var_2_8:startLoad(arg_2_0._onLvAnimLoaded, arg_2_0)

	arg_2_0._animLoaderList = arg_2_0._animLoaderList or {}

	table.insert(arg_2_0._animLoaderList, var_2_8)
	table.insert(arg_2_0._effectGOList, var_2_4)
	table.insert(arg_2_0._effectLoaderList, var_2_5)
end

function var_0_0._onLvEffectLoaded(arg_3_0, arg_3_1)
	gohelper.onceAddComponent(arg_3_1:getInstGO(), typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())

	local var_3_0 = arg_3_0._paramDict[arg_3_1]
	local var_3_1 = var_3_0.newCardLevel
	local var_3_2 = var_3_0.oldCardLv
	local var_3_3 = FightCardDataHelper.isBigSkill(arg_3_0._skillId)

	if lua_skill_next.configDict[arg_3_0._skillId] then
		var_3_3 = false
	end

	local var_3_4 = arg_3_1:getInstGO()
	local var_3_5 = gohelper.findChild(var_3_4, "#card/normal_effect")
	local var_3_6 = gohelper.findChild(var_3_4, "#card/ultimate_effect")

	gohelper.setActive(var_3_5, not var_3_3)
	gohelper.setActive(var_3_6, var_3_3)

	local var_3_7 = gohelper.findChild(var_3_4, "#star").transform
	local var_3_8 = var_3_7.childCount
	local var_3_9 = var_3_2 .. "_" .. var_3_1

	for iter_3_0 = 0, var_3_8 - 1 do
		local var_3_10 = var_3_7:GetChild(iter_3_0)

		if var_3_10 then
			gohelper.setActive(var_3_10.gameObject, var_3_10.name == var_3_9)
		end
	end
end

function var_0_0._onLvAnimLoaded(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._paramDict[arg_4_1]
	local var_4_1 = var_4_0.newCardLevel
	local var_4_2 = var_4_0.oldCardLv
	local var_4_3 = var_4_0.cardItem
	local var_4_4 = var_4_3.go

	gohelper.setActive(gohelper.findChild(var_4_4, "star/star1"), var_4_1 == 1 or var_4_2 == 1)
	gohelper.setActive(gohelper.findChild(var_4_4, "star/star2"), var_4_1 == 2 or var_4_2 == 2)
	gohelper.setActive(gohelper.findChild(var_4_4, "star/star3"), var_4_1 == 3 or var_4_2 == 3)

	for iter_4_0, iter_4_1 in ipairs(var_4_3._lvGOs) do
		gohelper.setActiveCanvasGroup(iter_4_1, var_4_1 == iter_4_0 or var_4_2 == iter_4_0)
	end

	local var_4_5

	if arg_4_0._changeFailType then
		-- block empty
	elseif var_4_2 < var_4_1 then
		var_4_5 = "fightcard_rising" .. var_4_2 .. "_" .. var_4_1
	else
		var_4_5 = "fightcard_escending" .. var_4_2 .. "_" .. var_4_1
	end

	if var_4_5 then
		local var_4_6 = gohelper.onceAddComponent(var_4_4, typeof(UnityEngine.Animator))

		var_4_6.runtimeAnimatorController = nil
		var_4_6.runtimeAnimatorController = arg_4_1:getFirstAssetItem():GetResource()
		var_4_6.speed = FightModel.instance:getUISpeed()
		var_4_6.enabled = true

		var_4_6:Play(var_4_5, 0, 0)
		var_4_6:Update(0)

		arg_4_0._animCompList = arg_4_0._animCompList or {}

		table.insert(arg_4_0._animCompList, var_4_6)
	end
end

function var_0_0._delayDone(arg_5_0)
	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._removeDownEffect, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
	arg_6_0:_removeDownEffect()
	arg_6_0:_removeLvAnim()

	arg_6_0._imgMaskMatDict = nil
	arg_6_0._imgList = nil
	arg_6_0._paramDict = nil
end

function var_0_0._removeDownEffect(arg_7_0)
	if arg_7_0._effectLoaderList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._effectLoaderList) do
			iter_7_1:dispose()
		end
	end

	if arg_7_0._effectGOList then
		for iter_7_2, iter_7_3 in ipairs(arg_7_0._effectGOList) do
			gohelper.destroy(iter_7_3)
		end
	end

	arg_7_0._effectGOList = nil
	arg_7_0._effectLoaderList = nil
end

function var_0_0._removeLvAnim(arg_8_0)
	if arg_8_0._animLoaderList then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._animLoaderList) do
			iter_8_1:dispose()
		end
	end

	arg_8_0._animLoaderList = nil

	if arg_8_0._animCompList then
		for iter_8_2, iter_8_3 in ipairs(arg_8_0._animCompList) do
			if not gohelper.isNil(iter_8_3) then
				iter_8_3.runtimeAnimatorController = nil
			end
		end
	end

	arg_8_0._animCompList = nil
end

return var_0_0
