module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.model.VersionActivity1_2NoteModel", package.seeall)

local var_0_0 = class("VersionActivity1_2NoteModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onReceiveGet121InfosReply(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == 0 then
		arg_3_0:_setData(arg_3_2)
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet121InfosReply, arg_3_1)
end

function var_0_0.getNotes(arg_4_0)
	return arg_4_0._notes
end

function var_0_0.getNote(arg_5_0, arg_5_1)
	return arg_5_0._notes and arg_5_0._notes[arg_5_1]
end

function var_0_0.setNote(arg_6_0, arg_6_1)
	arg_6_0._notes = arg_6_0._notes or {}
	arg_6_0._notes[arg_6_1] = arg_6_1
end

function var_0_0.getBonusFinished(arg_7_0, arg_7_1)
	return arg_7_0._getBonusStory and arg_7_0._getBonusStory[arg_7_1]
end

function var_0_0._setData(arg_8_0, arg_8_1)
	arg_8_0._notes = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.info.notes) do
		arg_8_0._notes[iter_8_1] = iter_8_1
	end

	arg_8_0._getBonusStory = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_1.info.getBonusStory) do
		arg_8_0._getBonusStory[iter_8_3] = iter_8_3
	end
end

function var_0_0.onReceiveGet121BonusReply(arg_9_0, arg_9_1)
	arg_9_0._getBonusStory = arg_9_0._getBonusStory or {}
	arg_9_0._getBonusStory[arg_9_1.storyId] = arg_9_1.storyId

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveGet121BonusReply, arg_9_1.storyId)
end

function var_0_0.onReceiveAct121UpdatePush(arg_10_0, arg_10_1)
	local var_10_0 = tabletool.copy(arg_10_0._notes or {})

	arg_10_0:_setData(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(arg_10_0._notes or {}) do
		if not var_10_0[iter_10_1] then
			local var_10_1 = lua_activity121_note.configDict[iter_10_1]

			if #string.splitToNumber(var_10_1.fightId, "#") == 0 then
				arg_10_0.showClueData = arg_10_0.showClueData or {}

				table.insert(arg_10_0.showClueData, {
					showPaper = true,
					id = iter_10_1
				})
			end
		end
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.onReceiveAct121UpdatePush)
end

function var_0_0.getClueData(arg_11_0)
	return arg_11_0.showClueData
end

function var_0_0.isCollectedAllNote(arg_12_0)
	return VersionActivity1_2NoteConfig.instance:getAllNoteCount() <= (arg_12_0._notes and tabletool.len(arg_12_0._notes) or 0)
end

function var_0_0.isAllBonusFinished(arg_13_0)
	local var_13_0 = VersionActivity1_2NoteConfig.instance:getStoryList()

	return tabletool.len(arg_13_0._getBonusStory) == tabletool.len(var_13_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
