module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessStoryViewContainer", package.seeall)

slot0 = class("Activity1_3ChessStoryViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot2 = ListScrollParam.New()
	slot2.scrollGOPath = "#scroll_ChapterList"
	slot2.prefabType = ScrollEnum.ScrollPrefabFromRes
	slot2.prefabUrl = Activity1_3ChessStoryViewItem.prefabPath
	slot2.cellClass = Activity1_3ChessStoryViewItem
	slot2.scrollDir = ScrollEnum.ScrollDirH
	slot2.lineCount = 1
	slot2.cellWidth = 500
	slot2.cellHeight = 720
	slot2.cellSpaceH = 0
	slot2.cellSpaceV = 0
	slot2.startSpace = 0

	table.insert(slot1, LuaListScrollView.New(Activity122StoryListModel.instance, slot2))
	table.insert(slot1, Activity1_3ChessStoryView.New())

	slot0._storyReviewScene = Va3ChessStoryReviewScene.New()

	table.insert(slot1, slot0._storyReviewScene)

	return slot1
end

function slot0.onContainerInit(slot0)
	Activity1_3ChessController.instance:setReviewStory(true)
end

function slot0.onContainerClose(slot0)
	Activity1_3ChessController.instance:setReviewStory(false)
end

function slot0.onContainerClickModalMask(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	slot0:closeThis()
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end
end

function slot0._setVisible(slot0, slot1)
	uv0.super._setVisible(slot0, slot1)

	if slot0._storyReviewScene and slot0._storyReviewSceneVisible ~= slot1 then
		slot0._storyReviewSceneVisible = slot1

		if slot1 then
			slot0._storyReviewScene:resetOpenAnim()
		end
	end
end

return slot0
