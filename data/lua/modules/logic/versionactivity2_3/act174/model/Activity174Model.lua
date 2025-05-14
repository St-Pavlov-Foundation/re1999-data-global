module("modules.logic.versionactivity2_3.act174.model.Activity174Model", package.seeall)

local var_0_0 = class("Activity174Model", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.actInfoDic = {}
	arg_2_0.turnShowUnlockTeamTipDict = nil
end

function var_0_0.getCurActId(arg_3_0)
	return arg_3_0.curActId
end

function var_0_0.getActInfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 or arg_4_0:getCurActId()
	local var_4_1 = arg_4_0.actInfoDic[var_4_0]

	if not var_4_1 then
		logError("actInfo not exist" .. arg_4_1)
	end

	return var_4_1
end

function var_0_0.setActInfo(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0.actInfoDic[arg_5_1] then
		local var_5_0 = Act174MO.New()

		arg_5_0.actInfoDic[arg_5_1] = var_5_0
	end

	arg_5_0.actInfoDic[arg_5_1]:initBadgeInfo(arg_5_1)
	arg_5_0.actInfoDic[arg_5_1]:init(arg_5_2)

	arg_5_0.curActId = arg_5_1
end

function var_0_0.updateGameInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0:getActInfo(arg_6_1):updateGameInfo(arg_6_2, arg_6_3)
	Activity174Controller.instance:dispatchEvent(Activity174Event.UpdateGameInfo)
end

function var_0_0.updateShopInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = arg_7_0:getActInfo(arg_7_1)

	var_7_0:updateShopInfo(arg_7_2)

	var_7_0.gameInfo.coin = arg_7_3
end

function var_0_0.updateTeamInfo(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:getActInfo(arg_8_1):updateTeamInfo(arg_8_2)
end

function var_0_0.updateIsBet(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0:getActInfo(arg_9_1):updateIsBet(arg_9_2)
end

function var_0_0.endGameReply(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_0:getActInfo(arg_10_1)

	var_10_0.gameInfo.state = Activity174Enum.GameState.None

	var_10_0:setEndInfo(arg_10_2)
	Activity174Controller.instance:dispatchEvent(Activity174Event.EndGame)
end

function var_0_0.triggerEffectPush(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	arg_11_0:getActInfo(arg_11_1):triggerEffectPush(arg_11_2, arg_11_3)
end

function var_0_0.initUnlockNewTeamTipCache(arg_12_0)
	if arg_12_0.turnShowUnlockTeamTipDict then
		return
	end

	local var_12_0 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, "")

	if not string.nilorempty(var_12_0) then
		arg_12_0.turnShowUnlockTeamTipDict = cjson.decode(var_12_0)
	end

	arg_12_0.turnShowUnlockTeamTipDict = arg_12_0.turnShowUnlockTeamTipDict or {}
end

function var_0_0.clearUnlockNewTeamTipCache(arg_13_0)
	arg_13_0.turnShowUnlockTeamTipDict = nil

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, "")
end

function var_0_0.setHasShowUnlockNewTeamTip(arg_14_0, arg_14_1)
	arg_14_0:initUnlockNewTeamTipCache()

	arg_14_0.turnShowUnlockTeamTipDict[tostring(arg_14_1)] = true

	local var_14_0 = cjson.encode(arg_14_0.turnShowUnlockTeamTipDict) or ""

	GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.DouQuQuHasUnlockNewTeam, var_14_0)
end

function var_0_0.getIsShowUnlockNewTeamTip(arg_15_0, arg_15_1)
	local var_15_0 = false

	if Activity174Config.instance:isUnlockNewTeamTurn(arg_15_1) then
		arg_15_0:initUnlockNewTeamTipCache()

		var_15_0 = not arg_15_0.turnShowUnlockTeamTipDict[tostring(arg_15_1)]
	end

	return var_15_0
end

function var_0_0.geAttackStatisticsByServerData(arg_16_0, arg_16_1, arg_16_2)
	if not arg_16_1 then
		return
	end

	local var_16_0 = {}

	for iter_16_0, iter_16_1 in ipairs(arg_16_1) do
		local var_16_1 = arg_16_2[iter_16_1.heroUid]

		if var_16_1 then
			local var_16_2 = {
				heroUid = iter_16_1.heroUid,
				harm = iter_16_1.harm,
				hurt = iter_16_1.hurt,
				heal = iter_16_1.heal
			}
			local var_16_3 = {}

			for iter_16_2, iter_16_3 in ipairs(iter_16_1.cards) do
				var_16_3[iter_16_2] = {
					skillId = iter_16_3.skillId,
					useCount = iter_16_3.useCount
				}
			end

			var_16_2.cards = var_16_3
			var_16_2.getBuffs = iter_16_1.getBuffs

			local var_16_4 = Activity174Config.instance:getRoleCoByHeroId(var_16_1)

			var_16_2.entityMO = Activity174Helper.getEmptyFightEntityMO(var_16_2.heroUid, var_16_4)
			var_16_0[iter_16_0] = var_16_2
		end
	end

	return var_16_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
