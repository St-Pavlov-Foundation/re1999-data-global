module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuMo", package.seeall)

slot0 = pureTable("VersionActivity2_4SudokuMo")
slot1 = {
	["break"] = "中断",
	done = "成功",
	reset = "重新开始"
}

function slot0.ctor(slot0)
	slot0.beginTime = Time.realtimeSinceStartup
	slot0.undoNum = 0
	slot0.erroNum = 0
end

function slot0.setResult(slot0, slot1)
	slot0.result = slot1
end

function slot0.addUndoCount(slot0)
	slot0.undoNum = slot0.undoNum + 1
end

function slot0.addErrorCount(slot0)
	slot0.erroNum = slot0.erroNum + 1
end

function slot0.sendStatData(slot0)
	StatController.instance:track(StatEnum.EventName.SudokuResult, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - slot0.beginTime,
		[StatEnum.EventProperties.Result] = uv0[slot0.result],
		[StatEnum.EventProperties.SudokuBackNum] = slot0.undoNum,
		[StatEnum.EventProperties.SudokuErrorNum] = slot0.erroNum
	})
end

return slot0
