module("modules.logic.character.view.CharacterSpineGCView", package.seeall)

local var_0_0 = class("CharacterSpineGCView", BaseView)
local var_0_1 = 5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._skinList = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSpine, arg_2_0._recordSkin, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(CharacterController.instance, CharacterEvent.OnSwitchSpine, arg_3_0._recordSkin, arg_3_0)
end

function var_0_0.onOpenFinish(arg_4_0)
	arg_4_0:_recordSkin()
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_recordSkin()
end

function var_0_0.onClose(arg_6_0)
	arg_6_0._skinList = {}

	TaskDispatcher.cancelTask(arg_6_0._delayGC, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._clearUnusedBanks, arg_6_0)
end

function var_0_0._recordSkin(arg_7_0)
	local var_7_0 = arg_7_0.viewContainer.viewParam

	if var_7_0 and var_7_0.heroId then
		table.insert(arg_7_0._skinList, var_7_0.skin)

		if #arg_7_0._skinList > var_0_1 then
			if #arg_7_0._skinList < var_0_1 * 2 then
				TaskDispatcher.cancelTask(arg_7_0._delayGC, arg_7_0)
			end

			TaskDispatcher.runDelay(arg_7_0._delayGC, arg_7_0, 1)
		end

		TaskDispatcher.cancelTask(arg_7_0._clearUnusedBanks, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0._clearUnusedBanks, arg_7_0, 0.1)
	end
end

function var_0_0._clearUnusedBanks(arg_8_0)
	AudioMgr.instance:clearUnusedBanks()
end

function var_0_0._delayGC(arg_9_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, arg_9_0)

	arg_9_0._skinList = {}
end

return var_0_0
