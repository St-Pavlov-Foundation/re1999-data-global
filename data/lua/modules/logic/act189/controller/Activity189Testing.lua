module("modules.logic.act189.controller.Activity189Testing", package.seeall)

slot0 = table.insert
slot1 = _G.class("TestingBase")
slot2 = TaskEnum.TaskType.Activity189

function slot1.ctor(slot0)
	slot0._pb = Activity189Module_pb
	slot0._cCfg = Activity189Config
	slot0._cTaskCfg = TaskConfig
	slot0._pbTask = TaskModule_pb
end

function slot1.build_test(slot0)
end

function slot1.link(slot0, slot1)
	slot0._obj = slot1
end

slot3 = 0
slot4 = 1
slot5 = "服务器异常"
slot6 = "returnCode: -2"
slot7 = _G.class("STesting", slot1)

function slot7.ctor(slot0)
	uv0.ctor(slot0)

	slot0._taskInfoDict = {}
	slot0._taskActivityInfoDict = {}
end

function slot7._make_taskInfos(slot0, slot1)
	slot2 = {}

	if slot1 == uv0 then
		for slot6, slot7 in ipairs(lua_activity189_task.configList) do
			slot8 = slot7.id
			slot2[slot9] = slot2[slot7.activityId] or {}

			if slot7.isOnline then
				slot2[slot9][slot8] = slot0:_make_TaskInfo(slot8, slot1)
			end
		end
	else
		assert(false, "please init task type: " .. slot1)
	end

	return slot2
end

function slot7._make_TaskActivityInfo(slot0, slot1)
	return {
		defineId = 0,
		expiryTime = 0,
		value = 0,
		gainValue = 0,
		typeId = slot1
	}
end

function slot7.handleGetTaskInfoReply(slot0, slot1, slot2)
	slot4 = {}
	slot5 = {}

	for slot9, slot10 in ipairs(slot1.typeIds) do
		if not slot0._taskInfoDict[slot10] then
			slot0._taskInfoDict[slot10] = slot0:_make_taskInfos(slot10)
		end

		if not slot0._taskActivityInfoDict[slot10] then
			slot0._taskActivityInfoDict[slot10] = slot0:_make_TaskActivityInfo(slot10)
		end

		for slot14, slot15 in pairs(slot0._taskInfoDict[slot10]) do
			for slot19, slot20 in pairs(slot15) do
				uv0(slot4, slot20)
			end
		end

		uv0(slot5, slot0._taskActivityInfoDict[slot10])
	end

	rawset(slot2, "taskInfo", slot4)
	rawset(slot2, "activityInfo", slot5)
	rawset(slot2, "typeIds", slot3)
end

function slot7._make_TaskInfo(slot0, slot1, slot2)
	slot3 = TaskModel.instance:getTaskConfig(slot2, slot1)

	assert(slot3, uv0)

	slot4 = slot3.maxProgress
	slot5.hasFinished = ({
		hasFinished = false,
		expiryTime = 0,
		finishCount = 0,
		id = slot1,
		type = slot2,
		progress = math.random(0, slot4)
	}).progress == slot4

	return slot5
end

slot8 = 0
slot9 = _G.class("CTesting", slot1)

function slot9.ctor(slot0)
	uv0.ctor(slot0)

	slot0._cRpc = Activity189Rpc
	slot0._cCtrl = Activity189Controller
	slot0._cModel = Activity189Model
	slot0._cTaskRpc = TaskRpc
	slot0._cTaskModel = TaskModel
	slot0._cTaskController = TaskController
end

function slot9.build_test(slot0)
	slot0:build_test__Task()
	slot0:build_test__Player()
end

function slot9.build_test__Player(slot0)
	function PlayerModel.forceSetSimpleProperty()
	end
end

function slot9.build_test__Task(slot0)
	slot1 = slot0._cTaskCfg.instance
	slot2 = slot0._cTaskRpc.instance
	slot3 = slot0._cTaskController.instance
	slot4 = slot0._cTaskModel.instance
	slot5 = slot0._pbTask

	function slot0._cTaskRpc.sendGetTaskInfoRequest(slot0, slot1, slot2, slot3)
		for slot8, slot9 in pairs(slot1) do
			table.insert(uv0.GetTaskInfoRequest().typeIds, slot9)
		end

		if #slot1 == 1 and slot1[1] == uv1 then
			slot5 = uv0.GetTaskInfoReply()

			uv2._obj:handleGetTaskInfoReply(slot4, slot5)
			uv3:onReceiveGetTaskInfoReply(uv4, slot5)

			if slot2 then
				if slot3 then
					slot2(slot3, LuaSocketMgr.instance:getCmdByPbStructName(slot4.__cname), uv4)
				else
					slot2(slot6, uv4)
				end
			end
		else
			return slot0:sendMsg(slot4, slot2, slot3)
		end
	end
end

slot10 = _G.class("Activity189Testing")

function slot10.ctor(slot0)
	slot0._client = uv0.New()
	slot0._sever = uv1.New()

	slot0._sever:link(slot0._client)
	slot0._client:link(slot0._sever)
end

function slot10._test(slot0)
	slot0._client:build_test()
	slot0._sever:build_test()
end

slot10.instance = slot10.New()

return slot10
