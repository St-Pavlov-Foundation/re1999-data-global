module("modules.logic.dungeon.view.maze.DungeonMazeWordEffectView", package.seeall)

local var_0_0 = class("DungeonMazeWordEffectView", BaseViewExtended)
local var_0_1 = {
	{
		id = 1,
		pos = "0#0"
	}
}
local var_0_2 = 6

function var_0_0.onInitView(arg_1_0)
	arg_1_0._leftWordRoot = gohelper.findChild(arg_1_0.viewGO, "Road/road1/obstacleDialog")
	arg_1_0._rightWordRoot = gohelper.findChild(arg_1_0.viewGO, "Road/road2/obstacleDialog")
	arg_1_0._bottomWordRoot = gohelper.findChild(arg_1_0.viewGO, "Road/road3/obstacleDialog")
	arg_1_0._topWordRoot = gohelper.findChild(arg_1_0.viewGO, "Road/road4/obstacleDialog")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.rightWordContentGO = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[1], arg_2_0._rightWordRoot)
	arg_2_0.rightWordEffect = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[2], arg_2_0.rightWordContentGO)
	arg_2_0.leftWordContentGO = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[1], arg_2_0._leftWordRoot)
	arg_2_0.leftWordEffect = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[2], arg_2_0.leftWordContentGO)
	arg_2_0.bottomWordContentGO = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[1], arg_2_0._bottomWordRoot)
	arg_2_0.bottomWordEffect = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[2], arg_2_0.bottomWordContentGO)
	arg_2_0.topWordContentGO = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[1], arg_2_0._topWordRoot)
	arg_2_0.topWordEffect = arg_2_0:getResInst(arg_2_0.viewContainer._viewSetting.otherRes[2], arg_2_0.topWordContentGO)

	gohelper.setActive(arg_2_0.leftWordContentGO, false)
	gohelper.setActive(arg_2_0.leftWordEffect, false)
	gohelper.setActive(arg_2_0.rightWordContentGO, false)
	gohelper.setActive(arg_2_0.rightWordEffect, false)
	gohelper.setActive(arg_2_0.bottomWordContentGO, false)
	gohelper.setActive(arg_2_0.bottomWordEffect, false)
	gohelper.setActive(arg_2_0.topWordContentGO, false)
	gohelper.setActive(arg_2_0.topWordEffect, false)

	arg_2_0._dirDialogRootMap = arg_2_0:getUserDataTb_()
	arg_2_0._dirDialogRootMap[DungeonMazeEnum.dir.left] = arg_2_0._leftWordRoot
	arg_2_0._dirDialogRootMap[DungeonMazeEnum.dir.right] = arg_2_0._rightWordRoot
	arg_2_0._dirDialogRootMap[DungeonMazeEnum.dir.down] = arg_2_0._bottomWordRoot
	arg_2_0._dirDialogRootMap[DungeonMazeEnum.dir.up] = arg_2_0._topWordRoot
	arg_2_0._dirWordObjMap = arg_2_0:getUserDataTb_()
	arg_2_0._dirWordObjMap[DungeonMazeEnum.dir.left] = arg_2_0.leftWordContentGO
	arg_2_0._dirWordObjMap[DungeonMazeEnum.dir.right] = arg_2_0.rightWordContentGO
	arg_2_0._dirWordObjMap[DungeonMazeEnum.dir.down] = arg_2_0.bottomWordContentGO
	arg_2_0._dirWordObjMap[DungeonMazeEnum.dir.up] = arg_2_0.topWordContentGO
	arg_2_0._dirWordEffectObjMap = arg_2_0:getUserDataTb_()
	arg_2_0._dirWordEffectObjMap[DungeonMazeEnum.dir.left] = arg_2_0.leftWordEffect
	arg_2_0._dirWordEffectObjMap[DungeonMazeEnum.dir.right] = arg_2_0.rightWordEffect
	arg_2_0._dirWordEffectObjMap[DungeonMazeEnum.dir.down] = arg_2_0.bottomWordEffect
	arg_2_0._dirWordEffectObjMap[DungeonMazeEnum.dir.up] = arg_2_0.topWordEffect
	arg_2_0._showEffectDirs = {}
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:addEventCb(DungeonMazeController.instance, DungeonMazeEvent.ShowMazeObstacleDialog, arg_3_0.showWordEffect, arg_3_0)
end

function var_0_0.showWordEffect(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0._showEffectDirs = arg_4_0._showEffectDirs or {}
	arg_4_0._showEffectDone = arg_4_0._showEffectDone and arg_4_0._showEffectDone or {}
	arg_4_0._showEffectDirs[arg_4_1] = arg_4_2
	arg_4_0._showEffectDone[arg_4_1] = arg_4_3

	arg_4_0:_refreshWordEffect()
end

function var_0_0._refreshWordEffect(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(DungeonMazeEnum.dir) do
		gohelper.setActive(arg_5_0._dirDialogRootMap[iter_5_1], arg_5_0._showEffectDirs[iter_5_1])

		if not string.nilorempty(arg_5_0._showEffectDirs[iter_5_1]) then
			if arg_5_0._wordEffectGo then
				gohelper.destroy(arg_5_0._wordEffectGo)

				arg_5_0._wordEffectGo = nil
			end

			local var_5_0 = arg_5_0._dirWordObjMap[iter_5_1]
			local var_5_1 = arg_5_0._dirWordEffectObjMap[iter_5_1]

			arg_5_0._wordEffectGo = gohelper.cloneInPlace(var_5_0)

			gohelper.setActive(arg_5_0._wordEffectGo, true)

			local var_5_2 = {
				tpye = 1,
				desc = arg_5_0._showEffectDirs[iter_5_1]
			}
			local var_5_3 = var_0_1[1]
			local var_5_4 = string.splitToNumber(var_5_3.pos, "#")

			recthelper.setAnchor(arg_5_0._wordEffectGo.transform, var_5_4[1], var_5_4[2])
			MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._wordEffectGo, DungeonMazeWordEffectComp, {
				dir = iter_5_1,
				parent = arg_5_0,
				co = var_5_2,
				res = var_5_1,
				done = arg_5_0._showEffectDone[iter_5_1]
			})
		else
			local var_5_5 = arg_5_0._dirWordObjMap[iter_5_1]
			local var_5_6 = arg_5_0._dirWordEffectObjMap[iter_5_1]

			gohelper.setActive(var_5_5, false)
			gohelper.setActive(var_5_6, false)
		end
	end
end

function var_0_0.onClose(arg_6_0)
	return
end

return var_0_0
