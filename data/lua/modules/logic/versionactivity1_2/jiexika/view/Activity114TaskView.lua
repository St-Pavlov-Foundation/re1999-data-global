module("modules.logic.versionactivity1_2.jiexika.view.Activity114TaskView", package.seeall)

slot0 = class("Activity114TaskView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagetxtbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#simage_txtbg")
	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot1 = ListScrollParam.New()
	slot1.scrollGOPath = "#scroll"
	slot1.prefabType = ScrollEnum.ScrollPrefabFromView
	slot1.prefabUrl = "#scroll/item"
	slot1.cellClass = Activity114TaskItem
	slot1.scrollDir = ScrollEnum.ScrollDirV
	slot1.lineCount = 1
	slot1.cellWidth = 1150
	slot1.cellHeight = 168
	slot1.cellSpaceH = 0
	slot1.cellSpaceV = 10.5
	slot1.startSpace = 5
	slot1.frameUpdateMs = 100

	for slot6 = 1, 6 do
	end

	slot0._csListView = SLFramework.UGUI.ListScrollView.Get(gohelper.findChild(slot0.viewGO, "#scroll"))
	slot0._scrollView = LuaListScrollViewWithAnimator.New(Activity114TaskModel.instance, slot1, {
		[slot6] = slot6 * 0.06
	})

	slot0:addChildView(slot0._scrollView)
	slot0._simagetxtbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("task/bg_heidi.png"))
end

function slot0.onOpen(slot0)
	slot0._csListView.VerticalScrollPixel = 0

	slot0._viewAnim:Play("open", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mission_open)
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.onClose(slot0)
	slot0._viewAnim:Play("close", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_close)
end

function slot0.onDestroyView(slot0)
	slot0._simagetxtbg:UnLoadImage()
end

return slot0
