module("modules.logic.character.view.CharacterSpineGCView", package.seeall)

slot0 = class("CharacterSpineGCView", BaseView)
slot1 = 5

function slot0.onInitView(slot0)
	slot0._skinList = {}
end

function slot0.addEvents(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.OnSwitchSpine, slot0._recordSkin, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.OnSwitchSpine, slot0._recordSkin, slot0)
end

function slot0.onOpenFinish(slot0)
	slot0:_recordSkin()
end

function slot0.onUpdateParam(slot0)
	slot0:_recordSkin()
end

function slot0.onClose(slot0)
	slot0._skinList = {}

	TaskDispatcher.cancelTask(slot0._delayGC, slot0)
	TaskDispatcher.cancelTask(slot0._clearUnusedBanks, slot0)
end

function slot0._recordSkin(slot0)
	if slot0.viewContainer.viewParam and slot1.heroId then
		table.insert(slot0._skinList, slot1.skin)

		if uv0 < #slot0._skinList then
			if #slot0._skinList < uv0 * 2 then
				TaskDispatcher.cancelTask(slot0._delayGC, slot0)
			end

			TaskDispatcher.runDelay(slot0._delayGC, slot0, 1)
		end

		TaskDispatcher.cancelTask(slot0._clearUnusedBanks, slot0)
		TaskDispatcher.runDelay(slot0._clearUnusedBanks, slot0, 0.1)
	end
end

function slot0._clearUnusedBanks(slot0)
	AudioMgr.instance:clearUnusedBanks()
end

function slot0._delayGC(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC, slot0)

	slot0._skinList = {}
end

return slot0
