module("modules.logic.toast.controller.ToastController", package.seeall)

slot0 = class("ToastController", BaseController)

function slot0.onInit(slot0)
	slot0._msgList = {}
	slot0._notToastList = {}
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
	slot0._msgList = {}
	slot0._notToastList = {}
end

function slot0.showToastWithIcon(slot0, slot1, slot2, ...)
	slot0._icon = slot2

	slot0:showToast(slot1, ...)

	slot0._icon = nil
end

function slot0.showToastWithExternalCall(slot0)
end

function slot0._showToast(slot0, slot1, slot2)
	if not ViewMgr.instance:isOpen(slot2 and ViewName.ToastTopView or ViewName.ToastView) then
		ViewMgr.instance:openView(slot3, slot1)

		return
	end

	if ViewMgr.instance:isOpenFinish(slot3) then
		slot0:dispatchEvent(ToastEvent.ShowToast, slot1)

		return
	end

	table.insert(slot0._msgList, slot1)
end

function slot0.showToast(slot0, slot1, ...)
	if slot0:PackToastObj(slot1, ...) and (isDebugBuild or slot2.co.notShow == 0) then
		slot0:_showToast(slot2)
	end
end

function slot0.PackToastObj(slot0, slot1, ...)
	if not (slot1 and ToastConfig.instance:getToastCO(slot1)) then
		logError(tostring(slot1) .. " 配置提示语！！《P飘字表》- export_飘字表")

		return
	end

	slot3 = {
		...
	}
	slot4 = false

	if slot2.notMerge == 0 then
		for slot8, slot9 in pairs(slot0._notToastList) do
			slot10 = false

			if slot9.extra and #slot3 == #slot9.extra then
				slot11 = true

				for slot15 = 1, #slot3 do
					if slot3[slot15] ~= slot9.extra[slot15] then
						slot11 = false

						break
					end
				end

				slot10 = slot11
			end

			if slot9.toastid == slot1 and slot10 then
				slot4 = true

				break
			end
		end
	end

	slot5 = ""

	if #slot3 > 0 then
		for slot9 = 1, #slot3 do
			slot5 = slot5 .. tostring(slot3[slot9])
		end
	end

	if not slot4 then
		slot0._notToastList[tostring(slot1) .. slot5] = {
			toastid = slot1,
			extra = slot3,
			time = ServerTime.now()
		}
	elseif not slot0:isExpire(slot0._notToastList[slot5].time) then
		return
	else
		slot0._notToastList[slot5].time = ServerTime.now()
	end

	return {
		co = slot2,
		extra = slot3,
		sicon = slot0._icon
	}
end

slot0.DefaultIconType = 11

function slot0.showToastWithString(slot0, slot1, slot2)
	if slot0._notToastList[slot1] and not slot0:isExpire(slot0._notToastList[slot1].time) then
		return
	end

	slot0._notToastList[slot1] = {
		time = ServerTime.now()
	}

	slot0:_showToast({
		co = {
			tips = slot1,
			icon = uv0.DefaultIconType
		}
	}, slot2)
end

function slot0.showToastWithCustomData(slot0, slot1, slot2, slot3, slot4, ...)
	if slot0:PackToastObj(slot1, ...) then
		if slot2 then
			slot2(slot3, slot5, slot4)
		end

		slot0:_showToast(slot5)
	end
end

function slot0.getToastMsg(slot0, slot1, ...)
	slot3 = ""

	if slot0:PackToastObj(slot1, ...) then
		slot3 = (not slot2.extra or #slot2.extra <= 0 or GameUtil.getSubPlaceholderLuaLang(slot2.co.tips, slot2.extra)) and slot2.co.tips
	end

	return slot3
end

function slot0.getToastMsgWithTableParam(slot0, slot1, slot2)
	if not (slot1 and ToastConfig.instance:getToastCO(slot1)) then
		logError("[ToastController] P飘字表.xlsx - export_飘字表 sheet error 不存在 toastId = " .. tostring(slot1))

		return ""
	end

	return slot2 and #slot2 > 0 and GameUtil.getSubPlaceholderLuaLang(slot3.tips, slot2) or slot3.tips
end

function slot0.isExpire(slot0, slot1)
	return ServerTime.now() - slot1 >= 4
end

slot0.instance = slot0.New()

return slot0
