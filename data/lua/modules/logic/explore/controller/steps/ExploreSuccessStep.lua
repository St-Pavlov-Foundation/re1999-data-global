module("modules.logic.explore.controller.steps.ExploreSuccessStep", package.seeall)

slot0 = class("ExploreSuccessStep", ExploreStepBase)

function slot0.onStart(slot0)
	ExploreRpc.instance:sendGetExploreSimpleInfoRequest()
	GameSceneMgr.instance:getCurScene().stat:onTriggerExit(ExploreController.instance:getMap():getUnitByType(ExploreEnum.ItemType.Exit).id)
	ExploreModel.instance:addChallengeCount()

	slot1 = ExploreController.instance:getMap()
	slot2 = slot1:getUnitByType(ExploreEnum.ItemType.Exit)
	slot3 = slot1:getHero()

	slot3:onCheckDir(slot3.nodePos, slot2.nodePos)
	slot3:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Finish, true)
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("ExploreSuccessStep")

	slot4 = (slot2:getPos() - slot3:getPos()):SetNormalize():Mul(1.3):Add(slot3:getPos())
	slot4.y = slot4.y + 0.25

	slot3:setTrOffset(nil, slot4, 2, nil, , EaseType.InOutSine)
	TaskDispatcher.runDelay(slot0.showFinishView, slot0, 2.3)
end

function slot0.showFinishView(slot0)
	ViewMgr.instance:openView(ViewName.ExploreFinishView, slot0._data)
	slot0:onDone()

	slot1 = ExploreModel.instance:getMapId()
	slot3 = false

	for slot7 = 1, #DungeonConfig.instance:getExploreChapterList() do
		for slot12 = 1, #DungeonConfig.instance:getChapterEpisodeCOList(slot2[slot7].id) do
			slot13 = lua_explore_scene.configDict[slot2[slot7].id][slot8[slot12].id]

			if slot3 then
				if not ExploreSimpleModel.instance:getEpisodeIsShowUnlock(slot13.chapterId, slot13.episodeId) then
					ExploreSimpleModel.instance:setLastSelectMap(slot13.chapterId, slot13.episodeId)
				end

				return
			elseif slot13.id == slot1 then
				slot3 = true
			end
		end
	end
end

function slot0.onDestory(slot0)
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("ExploreSuccessStep")
end

return slot0
