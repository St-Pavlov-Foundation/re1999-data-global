module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114DiceViewWork", package.seeall)

slot0 = class("Activity114DiceViewWork", Activity114OpenViewWork)

function slot0.onStart(slot0, slot1)
	if slot0.context.diceResult then
		slot0._viewName = ViewName.Activity114DiceView

		uv0.super.onStart(slot0, slot1)
	else
		slot0:onDone(true)
	end
end

return slot0
