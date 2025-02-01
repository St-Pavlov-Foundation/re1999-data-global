module("modules.logic.versionactivity1_2.jiexika.view.Activity114View", package.seeall)

slot0 = class("Activity114View", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg/#simage_rightbg")
	slot0._simagemirror = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mirror")
	slot0._simagemirrorlight2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mirrorlight2")
	slot0._simagespinemask = gohelper.findChildSingleImage(slot0.viewGO, "#simage_spinemask")
	slot0._simageframe = gohelper.findChildSingleImage(slot0.viewGO, "#simage_spinemask/#simage_frame")
	slot0._simagemirrorlight1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_mirrorlight1")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_bg.png"))
	slot0._simagerightbg:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("main/img_bg2.png"))
	slot0._simagemirror:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("bg_jingzi.png"))
	slot0._simagespinemask:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("zz_jingzi.png"))
	slot0._simageframe:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("bg_jingkuang.png"))
	slot0._simagemirrorlight2:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("img_jingzi_fangaung2.png"))
	slot0._simagemirrorlight1:LoadImage(ResUrl.getVersionActivityWhiteHouse_1_2_Bg("img_jingzi_fangaung1.png"))

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.addEvents(slot0)
	slot0:addEventCb(slot0.viewContainer, ViewEvent.ToSwitchTab, slot0.onTabChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(slot0.viewContainer, ViewEvent.ToSwitchTab, slot0.onTabChange, slot0)
end

function slot0.onTabChange(slot0, slot1, slot2, slot3)
	if slot1 ~= 2 then
		return
	end

	if slot2 == Activity114Enum.TabIndex.MainView then
		slot0._viewAnim:Play("start_open", 0, 0)

		slot0._lastOpenView = slot2
	elseif slot2 == Activity114Enum.TabIndex.TaskView then
		slot0._viewAnim:Play("quest_open", 0, 0)

		slot0._lastOpenView = slot2
	elseif slot3 == Activity114Enum.TabIndex.MainView then
		slot0._viewAnim:Play("start_close", 0, 0)
	elseif slot3 == Activity114Enum.TabIndex.TaskView then
		slot0._viewAnim:Play("quest_close", 0, 0)
	else
		slot0._viewAnim:Play("open", 0, 0)
	end
end

function slot0.onOpenFinish(slot0)
	slot0._viewAnim.enabled = true
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simagespinemask:UnLoadImage()
	slot0._simagemirror:UnLoadImage()
	slot0._simageframe:UnLoadImage()
	slot0._simagemirrorlight2:UnLoadImage()
	slot0._simagemirrorlight1:UnLoadImage()
end

return slot0
