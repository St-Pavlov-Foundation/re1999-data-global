module("modules.common.others.UICloneComponent", package.seeall)

slot0 = class("UICloneComponent", UserDataDispose)

function slot0.ctor(slot0)
	slot0:__onInit()

	slot0.create_data = slot0:getUserDataTb_()
end

function slot0.createObjList(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	if type(slot3) == "number" then
		slot3 = {}

		for slot13 = 1, slot3 do
			table.insert(slot3, slot13)
		end
	end

	if not slot4 then
		logError("没有传入格子父节点")

		return
	end

	if not slot5 then
		logError("没有传入格子模型")

		return
	end

	if slot7 then
		slot0:getUserDataTb_().total_num = #slot3
		slot9.delay_time = slot7 or 0.01
		slot9.create_count = slot8 or 1
		slot9.cur_count = 0
		slot9.class = slot1
		slot9.callback = slot2
		slot9.data = slot3
		slot9.parent_obj = slot4
		slot9.model_obj = slot5
		slot9.component = slot6
		slot9.start_time = Time.realtimeSinceStartup

		table.insert(slot0.create_data, slot9)
		TaskDispatcher.runRepeat(slot0._detectCloneState, slot0, 0.01)
	else
		gohelper.CreateObjList(slot1, slot2, slot3, slot4, slot5, slot6)
	end
end

function slot0._detectCloneState(slot0)
	for slot4, slot5 in ipairs(slot0.create_data) do
		if slot5.delay_time <= Time.realtimeSinceStartup - slot5.start_time then
			slot5.start_time = Time.realtimeSinceStartup

			if slot5.cur_count < slot5.total_num then
				slot6 = slot5.cur_count + 1
				slot5.cur_count = slot5.cur_count + slot5.create_count

				if slot5.total_num < slot5.cur_count then
					slot5.cur_count = slot5.total_num
				end

				gohelper.CreateObjList(slot5.class, slot5.callback, slot5.data, slot5.parent_obj, slot5.model_obj, slot5.component, slot6, slot5.cur_count)
			end
		end
	end

	for slot4 = #slot0.create_data, 1, -1 do
		slot5 = slot0.create_data[slot4]

		if slot5.total_num <= slot5.cur_count then
			table.remove(slot0.create_data, slot4)
		end
	end

	if #slot0.create_data == 0 then
		TaskDispatcher.cancelTask(slot0._detectCloneState, slot0)
	end
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._detectCloneState, slot0)
	slot0:__onDispose()
end

return slot0
