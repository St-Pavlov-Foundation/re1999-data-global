module("modules.logic.handbook.view.HandbookStoryItem", package.seeall)

slot0 = class("HandbookStoryItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._golinedown = gohelper.findChild(slot0.viewGO, "#go_layout/#go_linedown")
	slot0._golineup = gohelper.findChild(slot0.viewGO, "#go_layout/#go_lineup")
	slot0._golayout = gohelper.findChild(slot0.viewGO, "#go_layout")
	slot0._gofragmentinfolist = gohelper.findChild(slot0.viewGO, "#go_layout/#go_fragmentinfolist")
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "")
	slot0._txtstorynamecn = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_storynamecn")
	slot0._txtstorynameen = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_storynameen")
	slot0._simagestoryicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_layout/basic/mask/#simage_storyicon")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_time")
	slot0._txtdate = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_date")
	slot0._gomessycode = gohelper.findChild(slot0.viewGO, "#go_layout/basic/#go_messycode")
	slot0._txtyear = gohelper.findChildText(slot0.viewGO, "#go_year/#txt_year")
	slot0._txtyearmessycode = gohelper.findChildText(slot0.viewGO, "#go_year/#txt_yearmessycode")
	slot0._txtid = gohelper.findChildText(slot0.viewGO, "#go_layout/basic/#txt_id")
	slot0._gofragmentitem = gohelper.findChild(slot0.viewGO, "#go_layout/#go_fragmentinfolist/#go_fragmentitem")
	slot0._goyear = gohelper.findChild(slot0.viewGO, "#go_year")
	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

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

		slot3 = {
			levelIdDict = slot2,
			isReplay = true
		}

		if DungeonConfig.instance:getExtendStory(slot0._config.episodeId) then
			table.insert(slot1, slot4)
		end

		StoryController.instance:playStories(slot1, slot3)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gofragmentitem, false)

	slot0._fragmentItemList = slot0._fragmentItemList or {}

	gohelper.addUIClickAudio(slot0._btnplay.gameObject, AudioEnum.UI.play_ui_screenplay_plot_playback)
end

function slot0._refreshUI(slot0)
	slot0:_setUpDown()

	slot0._txtstorynamecn.text = slot0._config.name
	slot0._txtstorynameen.text = slot0._config.nameEn
	slot0._txttime.text = slot0._config.time
	slot0._txtdate.text = slot0._config.date

	gohelper.setActive(slot0._txttime.gameObject, not string.nilorempty(slot0._config.time))
	gohelper.setActive(slot0._txtdate.gameObject, not string.nilorempty(slot0._config.date))
	gohelper.setActive(slot0._gomessycode, string.nilorempty(slot0._config.time))

	slot1 = GameUtil.utf8isnum(slot0._config.year)

	gohelper.setActive(slot0._goyear, not string.nilorempty(slot0._config.year))
	gohelper.setActive(slot0._txtyear.gameObject, slot1)
	gohelper.setActive(slot0._txtyearmessycode.gameObject, not slot1)

	slot0._txtyear.text = slot1 and slot0._config.year or ""
	slot0._txtyearmessycode.text = slot1 and "" or slot0._config.year

	slot0._simagestoryicon:LoadImage(ResUrl.getStorySmallBg(slot0._config.image))

	if slot0._mo.index > 9 then
		slot0._txtid.text = tostring(slot0._mo.index)
	else
		slot0._txtid.text = "0" .. tostring(slot0._mo.index)
	end

	slot0:_refreshFragment()
end

function slot0._setUpDown(slot0)
	if slot0._mo.index % 2 ~= 0 then
		recthelper.setAnchorY(slot0._golayout.transform, 0)

		slot0._golayout.transform.pivot = Vector2(0.5, 0)

		gohelper.setAsLastSibling(slot0._gofragmentinfolist)
	else
		recthelper.setAnchorY(slot0._golayout.transform, -72)

		slot0._golayout.transform.pivot = Vector2(0.5, 1)

		gohelper.setAsFirstSibling(slot0._gofragmentinfolist)
	end

	gohelper.setActive(slot0._golineup, slot1)
	gohelper.setActive(slot0._golinedown, not slot1)
end

function slot0._refreshFragment(slot0)
	slot1 = {}

	if not string.nilorempty(slot0._config.fragmentIdList) then
		slot1 = string.splitToNumber(slot0._config.fragmentIdList, "#")
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._fragmentItemList[slot5] then
			slot7 = {
				go = gohelper.cloneInPlace(slot0._gofragmentitem, "item" .. slot5)
			}
			slot7.txtinfo = gohelper.findChildText(slot7.go, "info")
			slot7.btnclick = gohelper.findChildButtonWithAudio(slot7.go, "info/btnclick")

			slot7.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot7)
			table.insert(slot0._fragmentItemList, slot7)
		end

		slot7.fragmentId = slot6
		slot7.dialogIdList = HandbookModel.instance:getFragmentDialogIdList(slot6)

		if slot7.dialogIdList then
			slot7.txtinfo.text = lua_chapter_map_fragment.configDict[slot6].title
		else
			slot7.txtinfo.text = "???"
		end

		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._fragmentItemList do
		gohelper.setActive(slot0._fragmentItemList[slot5].go, false)
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	if slot1.dialogIdList then
		ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, {
			isFromHandbook = true,
			fragmentId = slot1.fragmentId,
			dialogIdList = slot1.dialogIdList
		})
	else
		GameFacade.showToast(ToastEnum.HandBook2)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._config = HandbookConfig.instance:getStoryGroupConfig(slot0._mo.storyGroupId)

	slot0:_refreshUI()
end

function slot0.getAnimator(slot0)
	return slot0._anim
end

function slot0.onDestroy(slot0)
	slot0._simagestoryicon:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._fragmentItemList) do
		slot5.btnclick:RemoveClickListener()
	end
end

return slot0
