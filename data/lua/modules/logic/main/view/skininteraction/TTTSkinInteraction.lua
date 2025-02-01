module("modules.logic.main.view.skininteraction.TTTSkinInteraction", package.seeall)

slot0 = class("TTTSkinInteraction", BaseSkinInteraction)

function slot0._onInit(slot0)
	slot0._tvOff = false
	slot0._closeEffectList = nil
end

function slot0.isPlayingVoice(slot0)
	return slot0._tvOff
end

function slot0.onCloseFullView(slot0)
	slot0:_openTv()
end

function slot0._onClick(slot0, slot1)
	if not slot0:_checkPosInBound(slot1) then
		return
	end

	slot0._lightSpine = slot0._view._lightSpine

	if not slot0._tvOff and math.random() < CommonConfig.instance:getConstNum(ConstEnum.TTTCloseTv) / 100 then
		slot0._tvOff = true

		TaskDispatcher.cancelTask(slot0._hideCloseEffects, slot0)

		slot0._closeEffectList = slot0._closeEffectList or slot0._view:getUserDataTb_()

		for slot10 = 1, gohelper.findChild(slot0._lightSpine:getSpineGo(), "mountroot").transform.childCount do
			for slot15 = 1, slot5:GetChild(slot10 - 1).childCount do
				if string.find(slot11:GetChild(slot15 - 1).name, "close") then
					gohelper.setActive(slot16.gameObject, true)

					slot0._closeEffectList[slot10] = slot16.gameObject
				else
					gohelper.setActive(slot16.gameObject, false)
				end
			end
		end

		if slot0._lightSpine then
			slot0._lightSpine:stopVoice()
		end

		return
	end

	if slot0:_openTv() then
		return
	end

	slot0:_clickDefault(slot1)
end

function slot0._openTv(slot0)
	if slot0._tvOff then
		slot0._tvOff = false

		TaskDispatcher.cancelTask(slot0._hideCloseEffects, slot0)
		TaskDispatcher.runDelay(slot0._hideCloseEffects, slot0, 0.2)

		for slot8 = 1, gohelper.findChild(slot0._lightSpine:getSpineGo(), "mountroot").transform.childCount do
			for slot13 = 1, slot3:GetChild(slot8 - 1).childCount do
				if not string.find(slot9:GetChild(slot13 - 1).name, "close") then
					gohelper.setActive(slot14.gameObject, true)
				end
			end
		end

		return true
	end
end

function slot0._hideCloseEffects(slot0)
	for slot4, slot5 in pairs(slot0._closeEffectList) do
		gohelper.setActive(slot5, false)
	end
end

function slot0._onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._hideCloseEffects, slot0)

	slot0._closeEffectList = nil
	slot0._lightSpine = nil
end

return slot0
