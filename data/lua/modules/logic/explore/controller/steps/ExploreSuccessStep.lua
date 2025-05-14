module("modules.logic.explore.controller.steps.ExploreSuccessStep", package.seeall)

local var_0_0 = class("ExploreSuccessStep", ExploreStepBase)

function var_0_0.onStart(arg_1_0)
	ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	GameSceneMgr.instance:getCurScene().stat:onTriggerExit(ExploreController.instance:getMap():getUnitByType(ExploreEnum.ItemType.Exit).id)
	ExploreModel.instance:addChallengeCount()

	local var_1_0 = ExploreController.instance:getMap()
	local var_1_1 = var_1_0:getUnitByType(ExploreEnum.ItemType.Exit)
	local var_1_2 = var_1_0:getHero()

	var_1_2:onCheckDir(var_1_2.nodePos, var_1_1.nodePos)
	var_1_2:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Finish, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreSuccessStep")

	local var_1_3 = (var_1_1:getPos() - var_1_2:getPos()):SetNormalize():Mul(1.3):Add(var_1_2:getPos())

	var_1_3.y = var_1_3.y + 0.25

	var_1_2:setTrOffset(nil, var_1_3, 2, nil, nil, EaseType.InOutSine)
	TaskDispatcher.runDelay(arg_1_0.showFinishView, arg_1_0, 2.3)
end

function var_0_0.showFinishView(arg_2_0)
	ViewMgr.instance:openView(ViewName.ExploreFinishView, arg_2_0._data)
	arg_2_0:onDone()

	local var_2_0 = ExploreModel.instance:getMapId()
	local var_2_1 = DungeonConfig.instance:getExploreChapterList()
	local var_2_2 = false

	for iter_2_0 = 1, #var_2_1 do
		local var_2_3 = DungeonConfig.instance:getChapterEpisodeCOList(var_2_1[iter_2_0].id)

		for iter_2_1 = 1, #var_2_3 do
			local var_2_4 = lua_explore_scene.configDict[var_2_1[iter_2_0].id][var_2_3[iter_2_1].id]

			if var_2_2 then
				if not ExploreSimpleModel.instance:getEpisodeIsShowUnlock(var_2_4.chapterId, var_2_4.episodeId) then
					ExploreSimpleModel.instance:setLastSelectMap(var_2_4.chapterId, var_2_4.episodeId)
				end

				return
			elseif var_2_4.id == var_2_0 then
				var_2_2 = true
			end
		end
	end
end

function var_0_0.onDestory(arg_3_0)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreSuccessStep")
end

return var_0_0
