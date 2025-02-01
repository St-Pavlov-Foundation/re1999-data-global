module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114ChangeEventWork", package.seeall)

slot0 = class("Activity114ChangeEventWork", Activity114BaseWork)

function slot0.onStart(slot0)
	if slot0.context.preAttrs and slot0.context.nowWeek == Activity114Model.instance.serverData.week then
		for slot5 = 1, Activity114Enum.Attr.End - 1 do
			if Activity114Model.instance.attrDict[slot5] ~= slot0.context.preAttrs[slot5] then
				if not Activity114Model.instance.attrChangeDict then
					Activity114Model.instance.attrChangeDict = {}
				end

				Activity114Model.instance.attrChangeDict[slot5] = true
			end
		end
	else
		Activity114Model.instance.attrChangeDict = nil
	end

	Activity114Model.instance.preEventType = slot0.context.type
	Activity114Model.instance.preResult = slot0.context.result

	if slot0.context.type == Activity114Enum.EventType.KeyDay and slot0.context.eventCo.config.isCheckEvent == 0 then
		Activity114Model.instance.preResult = nil
	end

	for slot4 in pairs(Activity114Model.instance.changeEventList) do
		Activity114Controller.instance:dispatchEvent(slot4)
	end

	Activity114Model.instance.changeEventList = {}

	Activity114Controller.instance:dispatchEvent(Activity114Event.UnLockRedDotUpdate)
	slot0:onDone(true)
end

return slot0
