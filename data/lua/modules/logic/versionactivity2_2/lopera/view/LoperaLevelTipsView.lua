module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelTipsView", package.seeall)

local var_0_0 = class("LoperaLevelTipsView", BaseView)
local var_0_1 = LoperaEnum.MapCfgIdx
local var_0_2 = VersionActivity2_2Enum.ActivityId.Lopera
local var_0_3 = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._text = gohelper.findChildText(arg_1_0.viewGO, "Bg/#text")
	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_min_day_night)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, arg_2_0._onGetToDestination, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeMove, arg_2_0._onMoveInEpisode, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.ExitGame, arg_2_0.onExitGame, arg_2_0)

	local var_2_0 = arg_2_0.viewParam
	local var_2_1 = var_2_0.isBeginning

	arg_2_0._isFinishTips = var_2_0.isFinished

	local var_2_2 = var_2_0.isEndLess
	local var_2_3 = var_2_0.mapId

	if var_2_2 then
		local var_2_4 = Activity168Model.instance:getCurEpisodeId()
		local var_2_5 = Activity168Config.instance:getConstCfg(var_0_2, var_2_4).value2

		arg_2_0._text.text = var_2_5

		arg_2_0:_delayClose()
	elseif var_2_1 or arg_2_0._isFinishTips then
		local var_2_6 = Activity168Config.instance:getConstValueCfg(var_0_2, var_2_3)
		local var_2_7 = string.split(var_2_6.value2, "|")[var_2_1 and 1 or 2]

		arg_2_0._text.text = var_2_7

		arg_2_0:_delayClose()
	else
		local var_2_8 = var_2_0.cellIdx - 1
		local var_2_9 = Activity168Config.instance:getMapEndCell()
		local var_2_10 = Activity168Config.instance:getMapCell(var_2_8)[var_0_1.coord]
		local var_2_11 = var_2_9[var_0_1.coord]
		local var_2_12 = math.abs(var_2_10[1] - var_2_11[1]) + math.abs(var_2_10[2] - var_2_11[2])
		local var_2_13 = Activity168Config.instance:getConstCfg(var_0_2, 1).mlValue
		local var_2_14 = string.split(var_2_13, "|")
		local var_2_15 = {}

		for iter_2_0, iter_2_1 in ipairs(var_2_14) do
			local var_2_16 = string.split(iter_2_1, "#")
			local var_2_17 = var_2_16[1]
			local var_2_18 = var_2_16[2]

			var_2_15[tonumber(var_2_17)] = var_2_18
		end

		local var_2_19 = ""

		for iter_2_2, iter_2_3 in pairs(var_2_15) do
			if iter_2_2 <= var_2_12 then
				var_2_19 = iter_2_3
			else
				break
			end
		end

		local var_2_20 = var_2_10[1] < var_2_11[1] and luaLang("text_dir_east") or var_2_10[1] > var_2_11[1] and luaLang("text_dir_west") or ""
		local var_2_21 = var_2_10[2] < var_2_11[2] and luaLang("text_dir_north") or var_2_10[2] > var_2_11[2] and luaLang("text_dir_south") or ""
		local var_2_22 = var_2_0.mapId
		local var_2_23 = Activity168Config.instance:getConstValueCfg(var_0_2, var_2_22).mlValue
		local var_2_24

		if LangSettings.instance:isEn() then
			if string.nilorempty(var_2_21) then
				var_2_24 = {
					var_2_19,
					var_2_20
				}
			else
				var_2_24 = {
					var_2_19,
					var_2_20 .. "-" .. var_2_21
				}
			end
		else
			var_2_24 = {
				var_2_19,
				var_2_20 .. var_2_21
			}
		end

		arg_2_0._text.text = GameUtil.getSubPlaceholderLuaLang(var_2_23, var_2_24)
	end
end

function var_0_0._delayClose(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._doCloseAction, arg_3_0, var_0_3)
end

function var_0_0._doCloseAction(arg_4_0)
	arg_4_0._viewAnimator:Play("out", 0, 0)
	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 0.25)
end

function var_0_0._onGetToDestination(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.settleReason

	if LoperaEnum.ResultEnum.Quit == var_5_0 or LoperaEnum.ResultEnum.PowerUseup == var_5_0 then
		arg_5_0:_doCloseAction()
	end
end

function var_0_0._onMoveInEpisode(arg_6_0)
	if not arg_6_0._isFinishTips then
		arg_6_0:_doCloseAction()
	end
end

function var_0_0.onExitGame(arg_7_0)
	arg_7_0:closeThis()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._doCloseAction, arg_9_0)
end

return var_0_0
