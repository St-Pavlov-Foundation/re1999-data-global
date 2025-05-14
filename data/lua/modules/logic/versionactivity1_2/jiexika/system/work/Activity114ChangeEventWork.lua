module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114ChangeEventWork", package.seeall)

local var_0_0 = class("Activity114ChangeEventWork", Activity114BaseWork)

function var_0_0.onStart(arg_1_0)
	if arg_1_0.context.preAttrs and arg_1_0.context.nowWeek == Activity114Model.instance.serverData.week then
		local var_1_0 = Activity114Model.instance.attrDict

		for iter_1_0 = 1, Activity114Enum.Attr.End - 1 do
			if var_1_0[iter_1_0] ~= arg_1_0.context.preAttrs[iter_1_0] then
				if not Activity114Model.instance.attrChangeDict then
					Activity114Model.instance.attrChangeDict = {}
				end

				Activity114Model.instance.attrChangeDict[iter_1_0] = true
			end
		end
	else
		Activity114Model.instance.attrChangeDict = nil
	end

	Activity114Model.instance.preEventType = arg_1_0.context.type
	Activity114Model.instance.preResult = arg_1_0.context.result

	if arg_1_0.context.type == Activity114Enum.EventType.KeyDay and arg_1_0.context.eventCo.config.isCheckEvent == 0 then
		Activity114Model.instance.preResult = nil
	end

	for iter_1_1 in pairs(Activity114Model.instance.changeEventList) do
		Activity114Controller.instance:dispatchEvent(iter_1_1)
	end

	Activity114Model.instance.changeEventList = {}

	Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	arg_1_0:onDone(true)
end

return var_0_0
