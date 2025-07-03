module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffectBossRush", package.seeall)

local var_0_0 = class("FightEntitySpecialEffectBossRush", UserDataDispose)
local var_0_1 = "_STYLIZATIONMOSTER2_ON"
local var_0_2 = "_NoiseMap3"
local var_0_3 = "noise_02_manual"
local var_0_4 = "_Pow"
local var_0_5 = {
	0,
	0.75,
	0.85,
	0.95
}
local var_0_6 = {
	[51400031] = true,
	[514000102] = true
}
local var_0_7 = 1

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._entity = arg_1_1
	arg_1_0._textureAssetItem = nil
	arg_1_0._texture = nil
	arg_1_0._isLoadingTexture = false
	arg_1_0._stageEffectList = {}

	TaskDispatcher.runDelay(arg_1_0._delayCheckMat, arg_1_0, 0.01)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_1_0._onSpineLoaded, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
end

function var_0_0._onSkillPlayStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	if arg_2_1 and arg_2_0._entity ~= arg_2_1 and arg_2_1:getMO() and FightCardDataHelper.isBigSkill(arg_2_2) then
		arg_2_0._uniqueSkill = arg_2_2

		arg_2_0:hideSpecialEffects("UniqueSkill")
	end
end

function var_0_0._onSkillPlayFinish(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	if arg_3_0._uniqueSkill and arg_3_2 == arg_3_0._uniqueSkill then
		arg_3_0._uniqueSkill = nil

		arg_3_0:showSpecialEffects("UniqueSkill")
	end
end

function var_0_0._onBuffUpdate(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if arg_4_1 ~= arg_4_0._entity.id then
		return
	end

	if var_0_6[arg_4_3] then
		if arg_4_2 == FightEnum.EffectType.BUFFDEL then
			local var_4_0 = arg_4_0._entity.spineRenderer:getReplaceMat()

			if var_4_0 then
				var_4_0:DisableKeyword(var_0_1)
			end

			arg_4_0:_delayCheckMat()
		else
			TaskDispatcher.cancelTask(arg_4_0._delayCheckMat, arg_4_0)

			local var_4_1 = 0.5 / FightModel.instance:getSpeed()

			TaskDispatcher.runDelay(arg_4_0._delayCheckMat, arg_4_0, var_4_1)
		end
	end
end

function var_0_0._delayCheckMat(arg_5_0)
	arg_5_0._pow_w_Value = nil

	local var_5_0 = arg_5_0._entity.spineRenderer:getReplaceMat()

	if not var_5_0 then
		return
	end

	local var_5_1 = 0
	local var_5_2 = arg_5_0._entity:getMO():getBuffDic()
	local var_5_3 = false

	for iter_5_0, iter_5_1 in pairs(var_5_2) do
		if var_0_6[iter_5_1.buffId] then
			var_5_3 = true
			var_5_1 = 1

			break
		end
	end

	local var_5_4
	local var_5_5 = false

	if not var_5_3 then
		local var_5_6 = BossRushModel.instance:getMultiHpInfo()

		var_5_4 = (var_5_6 and var_5_6.multiHpIdx or 0) + 1
		var_5_4 = Mathf.Clamp(var_5_4, 1, 4)

		if var_5_4 ~= 1 then
			var_5_5 = true
			var_5_1 = var_0_5[var_5_4]
		end
	end

	arg_5_0:_dealHangPointEffect(var_5_4, var_5_3)

	if not var_5_3 and not var_5_5 then
		return
	end

	arg_5_0._pow_w_Value = var_5_1

	var_5_0:EnableKeyword(var_0_1)

	local var_5_7 = var_5_0:GetVector(var_0_4)

	var_5_7.w = var_5_1

	var_5_0:SetVector(var_0_4, var_5_7)

	if arg_5_0._isLoadingTexture then
		return
	end

	if arg_5_0._texture then
		arg_5_0:_setTexture()
	else
		loadAbAsset(ResUrl.getRoleSpineMatTex(var_0_3), false, arg_5_0._onLoadCallback, arg_5_0)
	end
end

function var_0_0._onLoadCallback(arg_6_0, arg_6_1)
	if arg_6_1.IsLoadSuccess then
		arg_6_0._isLoadingTexture = false
		arg_6_0._textureAssetItem = arg_6_1

		arg_6_1:Retain()

		arg_6_0._texture = arg_6_1:GetResource()

		arg_6_0:_setTexture()
	end
end

function var_0_0._setTexture(arg_7_0)
	arg_7_0._entity.spineRenderer:getReplaceMat():SetTexture(var_0_2, arg_7_0._texture)

	local var_7_0 = FightHelper.getSideEntitys(arg_7_0._entity:getSide())

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1 ~= arg_7_0._entity then
			arg_7_0:_setOtherPartMat(iter_7_1)
		end
	end
end

function var_0_0._onSpineLoaded(arg_8_0, arg_8_1)
	if not arg_8_0._pow_w_Value or arg_8_0._pow_w_Value == 1 then
		return
	end

	local var_8_0 = arg_8_1.unitSpawn

	if var_8_0:getSide() == arg_8_0._entity:getSide() and var_8_0 ~= arg_8_0._entity then
		arg_8_0:_setOtherPartMat(var_8_0)
	end
end

function var_0_0._setOtherPartMat(arg_9_0, arg_9_1)
	if not arg_9_0._pow_w_Value or arg_9_0._pow_w_Value == 1 then
		return
	end

	local var_9_0 = arg_9_1.spineRenderer and arg_9_1.spineRenderer:getReplaceMat()

	if var_9_0 then
		var_9_0:EnableKeyword(var_0_1)

		local var_9_1 = var_9_0:GetVector(var_0_4)

		var_9_1.w = arg_9_0._pow_w_Value

		var_9_0:SetVector(var_0_4, var_9_1)
		var_9_0:SetTexture(var_0_2, arg_9_0._texture)
	end
end

function var_0_0._dealHangPointEffect(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._stageEffectList) do
		FightEffectPool.returnEffect(iter_10_1)
		FightEffectPool.returnEffectToPoolContainer(iter_10_1)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_10_0._entity.id, iter_10_1)
	end

	tabletool.clear(arg_10_0._stageEffectList)

	if arg_10_2 then
		return
	end

	local var_10_0 = arg_10_0._entity:getMO().skin
	local var_10_1 = lua_bossrush_skin_effect.configDict[var_10_0]

	if var_10_1 then
		local var_10_2 = arg_10_0._entity:getSide()

		for iter_10_2, iter_10_3 in pairs(var_10_1) do
			if arg_10_1 == iter_10_3.stage then
				local var_10_3 = string.split(iter_10_3.effects, "#")
				local var_10_4 = string.split(iter_10_3.hangpoints, "#")
				local var_10_5 = string.split(iter_10_3.scales, "#")

				for iter_10_4, iter_10_5 in ipairs(var_10_3) do
					local var_10_6 = var_10_4[iter_10_4] or ModuleEnum.SpineHangPointRoot
					local var_10_7 = arg_10_0._entity:getHangPoint(var_10_6)
					local var_10_8 = FightHelper.getEffectUrlWithLod(iter_10_5)
					local var_10_9 = FightEffectPool.getEffect(var_10_8, var_10_2, nil, nil, var_10_7)

					FightRenderOrderMgr.instance:onAddEffectWrap(arg_10_0._entity.id, var_10_9)
					var_10_9:setLocalPos(0, 0, 0)

					local var_10_10 = string.splitToNumber(var_10_5[iter_10_4], ",")

					var_10_9:setEffectScale(var_10_10[1] or 1, var_10_10[2] or 1, var_10_10[3] or 1)
					table.insert(arg_10_0._stageEffectList, var_10_9)
				end

				break
			end
		end
	end
end

function var_0_0.showSpecialEffects(arg_11_0, arg_11_1)
	if not arg_11_0._stageEffectList then
		return
	end

	arg_11_0:_clearMissingEffect()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._stageEffectList) do
		iter_11_1:setActive(true, arg_11_1 or arg_11_0.__cname)
	end
end

function var_0_0.hideSpecialEffects(arg_12_0, arg_12_1)
	if not arg_12_0._stageEffectList then
		return
	end

	arg_12_0:_clearMissingEffect()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._stageEffectList) do
		iter_12_1:setActive(false, arg_12_1 or arg_12_0.__cname)
	end
end

function var_0_0._clearMissingEffect(arg_13_0)
	for iter_13_0 = #arg_13_0._stageEffectList, 1, -1 do
		if gohelper.isNil(arg_13_0._stageEffectList[iter_13_0].containerGO) then
			table.remove(arg_13_0._stageEffectList, iter_13_0)
		end
	end
end

function var_0_0.releaseSelf(arg_14_0)
	if arg_14_0._stageEffectList then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0._stageEffectList) do
			FightEffectPool.returnEffect(iter_14_1)
			FightEffectPool.returnEffectToPoolContainer(iter_14_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_14_0._entity.id, iter_14_1)
		end
	end

	arg_14_0._stageEffectList = nil

	TaskDispatcher.cancelTask(arg_14_0._delayCheckMat, arg_14_0)
	arg_14_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_14_0._onBuffUpdate, arg_14_0)
	arg_14_0:removeEventCb(FightController.instance, FightEvent.OnSpineLoaded, arg_14_0._onSpineLoaded, arg_14_0)
	arg_14_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_14_0._onSkillPlayStart, arg_14_0)
	arg_14_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_14_0._onSkillPlayFinish, arg_14_0)

	if arg_14_0._textureAssetItem then
		arg_14_0._textureAssetItem:Release()

		arg_14_0._textureAssetItem = nil
	end

	arg_14_0._texture = nil

	arg_14_0:__onDispose()
end

function var_0_0.disposeSelf(arg_15_0)
	arg_15_0:releaseSelf()
end

return var_0_0
