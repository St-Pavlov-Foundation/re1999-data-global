module("modules.logic.versionactivity2_5.challenge.view.Act183DungeonHardMainGroupItem", package.seeall)

slot0 = class("Act183DungeonHardMainGroupItem", Act183DungeonBaseGroupItem)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._animUnlock = gohelper.onceAddComponent(slot0._golock, gohelper.Type_Animator)

	slot0:addEventCb(Act183Controller.instance, Act183Event.OnInitDungeonDone, slot0._onInitDungeonDone, slot0)
end

function slot0._onInitDungeonDone(slot0)
	slot0:_checkPlayNewUnlockAnim()
end

function slot0._checkPlayNewUnlockAnim(slot0)
	if Act183Model.instance:isHardMainGroupNewUnlock() then
		gohelper.setActive(slot0._golock, true)
		slot0._animUnlock:Play("unlock", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.UI.Act183_HardMainUnlock)
	end
end

return slot0
