module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuModel", package.seeall)

slot0 = class("VersionActivity2_4SudokuModel", BaseModel)
slot1 = "modules.configs.sudoku.lua_sudoku_%s"
slot2 = "lua_sudoku_%s"

function slot0.onInit(slot0)
	slot0._operateCmdList = {}
end

function slot0.reInit(slot0)
	slot0:init()
end

function slot0.init(slot0)
	slot0._curSelectItemIdx = 0
end

function slot0.selectItem(slot0, slot1)
	slot0._curSelectItemIdx = slot1
end

function slot0.getSelectedItem(slot0)
	return slot0._curSelectItemIdx
end

function slot0.selectKeyboardItem(slot0, slot1)
	slot0._curSelectKeyboardIdx = slot1
end

function slot0.getSelectedKeyboardItem(slot0)
	return slot0._curSelectKeyboardIdx
end

function slot0.pushCmd(slot0, slot1)
	slot0._operateCmdList[#slot0._operateCmdList + 1] = slot1
end

function slot0.popCmd(slot0)
	if #slot0._operateCmdList == 0 then
		return nil
	end

	slot0._operateCmdList[#slot0._operateCmdList] = nil

	return slot0._operateCmdList[#slot0._operateCmdList]
end

function slot0.clearCmd(slot0)
	slot0._operateCmdList = {}
end

function slot0.getSudokuCfg(slot0, slot1)
	return addGlobalModule(string.format(uv0, slot1), string.format("lua_chessgame_group_", slot1))
end

slot0.instance = slot0.New()

return slot0
