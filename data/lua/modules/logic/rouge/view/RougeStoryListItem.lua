module("modules.logic.rouge.view.RougeStoryListItem", package.seeall)

slot0 = class("RougeStoryListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._golayout = gohelper.findChild(slot0.viewGO, "#go_layout")
	slot0._simagestoryicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_layout/basic/mask/#simage_storyicon")
	slot0._txtid = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_id")
	slot0._txtstorynameen = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_storynameen")
	slot0._txtstorynamecn = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_storynamecn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnplay:AddClickListener(slot0._btnplayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnplay:RemoveClickListener()
end

function slot0._btnplayOnClick(slot0)
	if not string.nilorempty(slot0._config.storyIdList) then
		slot1 = string.splitToNumber(slot0._config.storyIdList, "#")
		slot2 = {}

		if not string.nilorempty(slot0._config.levelIdDict) then
			for slot7, slot8 in ipairs(string.split(slot0._config.levelIdDict, "|")) do
				slot9 = string.splitToNumber(slot8, "#")
				slot2[slot9[1]] = slot9[2]
			end
		end

		StoryController.instance:playStories(slot1, {
			levelIdDict = slot2,
			isReplay = true
		})
	end
end

function slot0._editableInitView(slot0)
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "")

	gohelper.addUIClickAudio(slot0._btnplay.gameObject, AudioEnum.UI.play_ui_screenplay_plot_playback)
end

function slot0._refreshUI(slot0)
	slot0._txtstorynamecn.text = slot0._config.name
	slot0._txtstorynameen.text = slot0._config.nameEn

	slot0._simagestoryicon:LoadImage(ResUrl.getStorySmallBg(slot0._config.image))

	if slot0._mo.index > 9 then
		slot0._txtid.text = tostring(slot0._mo.index)
	else
		slot0._txtid.text = "0" .. tostring(slot0._mo.index)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._config = slot1.config

	slot0:_refreshUI()
end

function slot0.getAnimator(slot0)
	return slot0._anim
end

function slot0.onDestroy(slot0)
	slot0._simagestoryicon:UnLoadImage()
end

return slot0
