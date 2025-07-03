module("modules.logic.fight.view.cardeffect.FightCardChangeEffectInWaitingArea", package.seeall)

local var_0_0 = class("FightCardChangeEffectInWaitingArea", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	arg_1_0._paramDict = {}

	arg_1_0:_playEffects()
	TaskDispatcher.runDelay(arg_1_0._removeDownEffect, arg_1_0, 1.2 / FightModel.instance:getUISpeed())
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 1.5 / FightModel.instance:getUISpeed())
end

function var_0_0._playEffects(arg_2_0)
	arg_2_0._effectGOList = {}
	arg_2_0._effectLoaderList = {}

	local var_2_0 = {}
	local var_2_1 = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.context.changeInfos) do
		for iter_2_2, iter_2_3 in ipairs(arg_2_0.context.cardItemList) do
			local var_2_2 = iter_2_3.go.activeInHierarchy
			local var_2_3 = FightCardDataHelper.getSkillPrevLvId(iter_2_3.entityId, iter_2_3.skillId)
			local var_2_4 = FightCardDataHelper.getSkillNextLvId(iter_2_3.entityId, iter_2_3.skillId)

			if var_2_2 and var_2_3 and var_2_3 == iter_2_1.targetSkillId then
				if not tabletool.indexOf(var_2_0, iter_2_3) then
					table.insert(var_2_0, iter_2_3)
					table.insert(var_2_1, iter_2_1)
				end
			elseif var_2_2 and var_2_4 and var_2_4 == iter_2_1.targetSkillId and not tabletool.indexOf(var_2_0, iter_2_3) then
				table.insert(var_2_0, iter_2_3)
				table.insert(var_2_1, iter_2_1)
			end
		end
	end

	if #var_2_0 > 0 then
		for iter_2_4, iter_2_5 in ipairs(var_2_0) do
			local var_2_5 = var_2_1[iter_2_4]
			local var_2_6 = var_2_5.entityId
			local var_2_7 = var_2_5.targetSkillId
			local var_2_8 = FightCardDataHelper.getSkillLv(iter_2_5.entityId, iter_2_5.skillId)
			local var_2_9 = iter_2_5.go
			local var_2_10 = gohelper.findChild(var_2_9, "lvChangeEffect") or gohelper.create2d(var_2_9, "lvChangeEffect")
			local var_2_11 = PrefabInstantiate.Create(var_2_10)
			local var_2_12 = FightCardDataHelper.getSkillLv(var_2_6, var_2_7)

			if var_2_12 ~= var_2_8 then
				arg_2_0._paramDict[var_2_11] = {
					newCardLevel = var_2_12,
					oldCardLevel = var_2_8
				}

				local var_2_13 = var_2_8 < var_2_12 and FightPreloadOthersWork.LvUpEffectPath or FightPreloadOthersWork.LvDownEffectPath

				var_2_11:startLoad(var_2_13, arg_2_0._onLvEffectLoaded, arg_2_0)

				local var_2_14 = var_2_8 < var_2_12 and ViewAnim.LvUpAnimPath or ViewAnim.LvDownAnimPath
				local var_2_15 = MultiAbLoader.New()

				arg_2_0._paramDict[var_2_15] = {
					newCardLevel = var_2_12,
					oldCardLevel = var_2_8,
					cardItem = iter_2_5
				}

				var_2_15:addPath(var_2_14)
				var_2_15:startLoad(arg_2_0._onLvAnimLoaded, arg_2_0)

				arg_2_0._animLoaderList = arg_2_0._animLoaderList or {}

				table.insert(arg_2_0._animLoaderList, var_2_15)
			else
				logError("手牌星级变更失败，等级相同：" .. iter_2_5.skillId .. " -> " .. var_2_7)
			end

			table.insert(arg_2_0._effectGOList, var_2_10)
			table.insert(arg_2_0._effectLoaderList, var_2_11)

			iter_2_5.op.skillId = var_2_7
		end
	else
		arg_2_0:onDone(true)
	end
end

function var_0_0._onLvEffectLoaded(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._paramDict[arg_3_1]
	local var_3_1 = var_3_0.newCardLevel

	if var_3_1 > var_3_0.oldCardLevel then
		gohelper.setActive(gohelper.findChild(arg_3_1:getInstGO(), "cardrising01"), var_3_1 == 2)
		gohelper.setActive(gohelper.findChild(arg_3_1:getInstGO(), "cardrising02"), var_3_1 == 3)
	else
		gohelper.setActive(gohelper.findChild(arg_3_1:getInstGO(), "starescending01"), var_3_1 == 1)
		gohelper.setActive(gohelper.findChild(arg_3_1:getInstGO(), "starescending02"), var_3_1 == 2)
	end
end

function var_0_0._onLvAnimLoaded(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._paramDict[arg_4_1]
	local var_4_1 = var_4_0.newCardLevel
	local var_4_2 = var_4_0.oldCardLevel
	local var_4_3 = var_4_0.cardItem
	local var_4_4 = var_4_3.go

	gohelper.setActive(gohelper.findChild(var_4_4, "star/star1"), var_4_1 == 1 or var_4_2 == 1)
	gohelper.setActive(gohelper.findChild(var_4_4, "star/star2"), var_4_1 == 2 or var_4_2 == 2)
	gohelper.setActive(gohelper.findChild(var_4_4, "star/star3"), var_4_1 == 3 or var_4_2 == 3)
	gohelper.onceAddComponent(gohelper.findChild(var_4_4, "lv1"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(var_4_4, "lv2"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(var_4_4, "lv3"), typeof(UnityEngine.UI.RectMask2D))
	gohelper.onceAddComponent(gohelper.findChild(var_4_4, "star/star1"), typeof(UnityEngine.CanvasGroup))
	gohelper.onceAddComponent(gohelper.findChild(var_4_4, "star/star2"), typeof(UnityEngine.CanvasGroup))
	gohelper.onceAddComponent(gohelper.findChild(var_4_4, "star/star3"), typeof(UnityEngine.CanvasGroup))

	local var_4_5 = gohelper.findChild(var_4_3.go, "lock")

	if var_4_5 and var_4_5.activeSelf then
		gohelper.setActive(var_4_5, false)

		arg_4_0._lockGO = var_4_5
	end

	local var_4_6
	local var_4_7, var_4_8, var_4_9 = transformhelper.getLocalScale(var_4_3.tr.parent)

	if var_4_2 < var_4_1 then
		if var_4_7 == 1 then
			var_4_6 = var_4_1 == 2 and "fightcard_rising03" or "fightcard_rising4"
		else
			var_4_6 = var_4_1 == 2 and "fightcard_rising01" or "fightcard_rising02"
		end
	elseif var_4_7 == 1 then
		var_4_6 = var_4_1 == 1 and "fightcard_escending03" or "fightcard_escending04"
	else
		var_4_6 = var_4_1 == 1 and "fightcard_escending01" or "fightcard_escending02"
	end

	local var_4_10 = gohelper.onceAddComponent(var_4_4, typeof(UnityEngine.Animator))

	var_4_10.runtimeAnimatorController = nil
	var_4_10.runtimeAnimatorController = arg_4_1:getFirstAssetItem():GetResource()
	var_4_10.speed = FightModel.instance:getUISpeed()

	var_4_10:Play(var_4_6, 0, 0)
	var_4_10:Update(0)

	arg_4_0._animCompList = arg_4_0._animCompList or {}

	table.insert(arg_4_0._animCompList, var_4_10)
	gohelper.setActiveCanvasGroup(gohelper.findChild(var_4_4, "lv1"), var_4_1 == 1 or var_4_2 == 1)
	gohelper.setActiveCanvasGroup(gohelper.findChild(var_4_4, "lv2"), var_4_1 == 2 or var_4_2 == 2)
	gohelper.setActiveCanvasGroup(gohelper.findChild(var_4_4, "lv3"), var_4_1 == 3 or var_4_2 == 3)
end

function var_0_0._delayDone(arg_5_0)
	if arg_5_0._lockGO then
		gohelper.setActive(arg_5_0._lockGO, true)

		arg_5_0._lockGO = nil
	end

	arg_5_0:onDone(true)
end

function var_0_0.clearWork(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._removeDownEffect, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
	arg_6_0:_removeDownEffect()
	arg_6_0:_removeLvAnim()

	arg_6_0._imgList = nil
	arg_6_0._lockGO = nil
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

				gohelper.removeComponent(gohelper.findChild(iter_8_3.gameObject, "lv1"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(iter_8_3.gameObject, "lv2"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(iter_8_3.gameObject, "lv3"), typeof(UnityEngine.UI.RectMask2D))
				gohelper.removeComponent(gohelper.findChild(iter_8_3.gameObject, "star/star1"), typeof(UnityEngine.CanvasGroup))
				gohelper.removeComponent(gohelper.findChild(iter_8_3.gameObject, "star/star2"), typeof(UnityEngine.CanvasGroup))
				gohelper.removeComponent(gohelper.findChild(iter_8_3.gameObject, "star/star3"), typeof(UnityEngine.CanvasGroup))
			end
		end
	end

	arg_8_0._animCompList = nil
end

return var_0_0
