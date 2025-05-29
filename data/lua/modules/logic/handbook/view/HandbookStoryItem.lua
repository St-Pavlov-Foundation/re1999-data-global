module("modules.logic.handbook.view.HandbookStoryItem", package.seeall)

local var_0_0 = class("HandbookStoryItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golinedown = gohelper.findChild(arg_1_0.viewGO, "#go_layout/#go_linedown")
	arg_1_0._golineup = gohelper.findChild(arg_1_0.viewGO, "#go_layout/#go_lineup")
	arg_1_0._golayout = gohelper.findChild(arg_1_0.viewGO, "#go_layout")
	arg_1_0._gofragmentinfolist = gohelper.findChild(arg_1_0.viewGO, "#go_layout/#go_fragmentinfolist")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "")
	arg_1_0._txtstorynamecn = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_storynamecn")
	arg_1_0._txtstorynameen = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_storynameen")
	arg_1_0._simagestoryicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_layout/basic/mask/#simage_storyicon")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_time")
	arg_1_0._txtdate = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_date")
	arg_1_0._gomessycode = gohelper.findChild(arg_1_0.viewGO, "#go_layout/basic/#go_messycode")
	arg_1_0._txtyear = gohelper.findChildText(arg_1_0.viewGO, "#go_year/#txt_year")
	arg_1_0._txtyearmessycode = gohelper.findChildText(arg_1_0.viewGO, "#go_year/#txt_yearmessycode")
	arg_1_0._txtid = gohelper.findChildText(arg_1_0.viewGO, "#go_layout/basic/#txt_id")
	arg_1_0._gofragmentitem = gohelper.findChild(arg_1_0.viewGO, "#go_layout/#go_fragmentinfolist/#go_fragmentitem")
	arg_1_0._goyear = gohelper.findChild(arg_1_0.viewGO, "#go_year")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnplay:RemoveClickListener()
end

function var_0_0._btnplayOnClick(arg_4_0)
	if not string.nilorempty(arg_4_0._config.storyIdList) then
		local var_4_0 = string.splitToNumber(arg_4_0._config.storyIdList, "#")
		local var_4_1 = {}

		if not string.nilorempty(arg_4_0._config.levelIdDict) then
			local var_4_2 = string.split(arg_4_0._config.levelIdDict, "|")

			for iter_4_0, iter_4_1 in ipairs(var_4_2) do
				local var_4_3 = string.splitToNumber(iter_4_1, "#")

				var_4_1[var_4_3[1]] = var_4_3[2]
			end
		end

		local var_4_4 = {
			levelIdDict = var_4_1
		}

		var_4_4.isReplay = true

		local var_4_5 = DungeonConfig.instance:getExtendStory(arg_4_0._config.episodeId)

		if var_4_5 then
			table.insert(var_4_0, var_4_5)
		end

		StoryController.instance:playStories(var_4_0, var_4_4)
	end
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.setActive(arg_5_0._gofragmentitem, false)

	arg_5_0._fragmentItemList = arg_5_0._fragmentItemList or {}

	gohelper.addUIClickAudio(arg_5_0._btnplay.gameObject, AudioEnum.UI.play_ui_screenplay_plot_playback)
end

function var_0_0._refreshUI(arg_6_0)
	arg_6_0:_setUpDown()

	arg_6_0._txtstorynamecn.text = arg_6_0._config.name
	arg_6_0._txtstorynameen.text = arg_6_0._config.nameEn
	arg_6_0._txttime.text = arg_6_0._config.time
	arg_6_0._txtdate.text = arg_6_0._config.date

	gohelper.setActive(arg_6_0._txttime.gameObject, not string.nilorempty(arg_6_0._config.time))
	gohelper.setActive(arg_6_0._txtdate.gameObject, not string.nilorempty(arg_6_0._config.date))
	gohelper.setActive(arg_6_0._gomessycode, string.nilorempty(arg_6_0._config.time))

	local var_6_0 = GameUtil.utf8isnum(arg_6_0._config.year)

	gohelper.setActive(arg_6_0._goyear, not string.nilorempty(arg_6_0._config.year))
	gohelper.setActive(arg_6_0._txtyear.gameObject, var_6_0)
	gohelper.setActive(arg_6_0._txtyearmessycode.gameObject, not var_6_0)

	arg_6_0._txtyear.text = var_6_0 and arg_6_0._config.year or ""
	arg_6_0._txtyearmessycode.text = var_6_0 and "" or arg_6_0._config.year

	arg_6_0._simagestoryicon:LoadImage(ResUrl.getStorySmallBg(arg_6_0._config.image))

	if arg_6_0._mo.index > 9 then
		arg_6_0._txtid.text = tostring(arg_6_0._mo.index)
	else
		arg_6_0._txtid.text = "0" .. tostring(arg_6_0._mo.index)
	end

	arg_6_0:_refreshFragment()
end

function var_0_0._setUpDown(arg_7_0)
	local var_7_0 = arg_7_0._mo.index % 2 ~= 0

	if var_7_0 then
		recthelper.setAnchorY(arg_7_0._golayout.transform, 0)

		arg_7_0._golayout.transform.pivot = Vector2(0.5, 0)

		gohelper.setAsLastSibling(arg_7_0._gofragmentinfolist)
	else
		recthelper.setAnchorY(arg_7_0._golayout.transform, -72)

		arg_7_0._golayout.transform.pivot = Vector2(0.5, 1)

		gohelper.setAsFirstSibling(arg_7_0._gofragmentinfolist)
	end

	gohelper.setActive(arg_7_0._golineup, var_7_0)
	gohelper.setActive(arg_7_0._golinedown, not var_7_0)
end

function var_0_0._refreshFragment(arg_8_0)
	local var_8_0 = {}

	if not string.nilorempty(arg_8_0._config.fragmentIdList) then
		var_8_0 = string.splitToNumber(arg_8_0._config.fragmentIdList, "#")
	end

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = arg_8_0._fragmentItemList[iter_8_0]

		if not var_8_1 then
			var_8_1 = {
				go = gohelper.cloneInPlace(arg_8_0._gofragmentitem, "item" .. iter_8_0)
			}
			var_8_1.txtinfo = gohelper.findChildText(var_8_1.go, "info")
			var_8_1.btnclick = gohelper.findChildButtonWithAudio(var_8_1.go, "info/btnclick")

			var_8_1.btnclick:AddClickListener(arg_8_0._btnclickOnClick, arg_8_0, var_8_1)
			table.insert(arg_8_0._fragmentItemList, var_8_1)
		end

		local var_8_2 = lua_chapter_map_fragment.configDict[iter_8_1]

		var_8_1.fragmentId = iter_8_1
		var_8_1.dialogIdList = HandbookModel.instance:getFragmentDialogIdList(iter_8_1)

		if var_8_1.dialogIdList then
			var_8_1.txtinfo.text = var_8_2.title
		else
			var_8_1.txtinfo.text = "???"
		end

		gohelper.setActive(var_8_1.go, true)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0._fragmentItemList do
		local var_8_3 = arg_8_0._fragmentItemList[iter_8_2]

		gohelper.setActive(var_8_3.go, false)
	end
end

function var_0_0._btnclickOnClick(arg_9_0, arg_9_1)
	if arg_9_1.dialogIdList then
		local var_9_0 = arg_9_1.fragmentId

		if lua_chapter_map_fragment.configDict[var_9_0].type == DungeonEnum.FragmentType.AvgStory then
			local var_9_1 = DungeonConfig.instance:getMapElementByFragmentId(var_9_0)
			local var_9_2 = tonumber(var_9_1.param)

			StoryController.instance:playStory(var_9_2)
		else
			local var_9_3 = {
				fragmentId = var_9_0,
				dialogIdList = arg_9_1.dialogIdList
			}

			var_9_3.isFromHandbook = true

			ViewMgr.instance:openView(ViewName.DungeonFragmentInfoView, var_9_3)
		end
	else
		GameFacade.showToast(ToastEnum.HandBook2)
	end
end

function var_0_0.onUpdateMO(arg_10_0, arg_10_1)
	arg_10_0._mo = arg_10_1
	arg_10_0._config = HandbookConfig.instance:getStoryGroupConfig(arg_10_0._mo.storyGroupId)

	arg_10_0:_refreshUI()
end

function var_0_0.getAnimator(arg_11_0)
	return arg_11_0._anim
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0._simagestoryicon:UnLoadImage()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._fragmentItemList) do
		iter_12_1.btnclick:RemoveClickListener()
	end
end

return var_0_0
