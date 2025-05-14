module("modules.logic.seasonver.act123.view2_3.Season123_2_3EnemyTabList", package.seeall)

local var_0_0 = class("Season123_2_3EnemyTabList", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebattlelistbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_battlelist/#simage_battlelistbg")
	arg_1_0._gobattlebtntemplate = gohelper.findChild(arg_1_0.viewGO, "go_battlelist/scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))

	arg_2_0._tabItems = {}
end

function var_0_0.onDestroyView(arg_3_0)
	if arg_3_0._tabItems then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._tabItems) do
			iter_3_1.btn:RemoveClickListener()
		end

		arg_3_0._tabItems = nil
	end

	arg_3_0._simagebattlelistbg:UnLoadImage()
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(Season123Controller.instance, Season123Event.EnemyDetailSwitchTab, arg_4_0.refreshSelect, arg_4_0)
	arg_4_0:refreshUI()
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0:refreshItems()
	arg_5_0:refreshSelect()
end

function var_0_0.refreshItems(arg_6_0)
	local var_6_0 = Season123EnemyModel.instance:getBattleIds()

	for iter_6_0 = 1, #var_6_0 do
		local var_6_1 = arg_6_0:getOrCreateTabItem(iter_6_0)

		var_6_1.txt.text = "0" .. tostring(iter_6_0)

		local var_6_2 = var_6_0[iter_6_0]
		local var_6_3 = 1

		for iter_6_1 = 1, var_6_1.starCount do
			local var_6_4 = var_6_1["imageStar" .. iter_6_1]

			if var_6_4 then
				UISpriteSetMgr.instance:setWeekWalkSprite(var_6_4, iter_6_1 <= var_6_3 and "star_highlight4" or "star_null4", true)
			end
		end
	end
end

function var_0_0.getOrCreateTabItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._tabItems[arg_7_1]

	if not var_7_0 then
		var_7_0 = arg_7_0:getUserDataTb_()

		local var_7_1 = gohelper.cloneInPlace(arg_7_0._gobattlebtntemplate)

		var_7_0.go = var_7_1

		gohelper.setActive(var_7_0.go, true)

		var_7_0.btn = gohelper.findChildButton(var_7_1, "btn")
		var_7_0.txt = gohelper.findChildText(var_7_1, "txt")
		var_7_0.selectIcon = gohelper.findChild(var_7_1, "selectIcon")
		var_7_0.starGo2 = gohelper.findChild(var_7_1, "star2")
		var_7_0.starGo3 = gohelper.findChild(var_7_1, "star3")
		var_7_0.starGo = var_7_0.starGo3

		gohelper.setActive(var_7_0.starGo2, false)
		gohelper.setActive(var_7_0.starGo3, false)
		gohelper.setActive(var_7_0.starGo, true)

		local var_7_2 = var_7_0.starGo.transform

		var_7_0.starCount = var_7_2.childCount

		for iter_7_0 = 1, var_7_0.starCount do
			local var_7_3 = var_7_2:GetChild(iter_7_0 - 1):GetComponentInChildren(gohelper.Type_Image)

			var_7_0["imageStar" .. iter_7_0] = var_7_3
		end

		var_7_0.btn:AddClickListener(arg_7_0.onClickTab, arg_7_0, arg_7_1)
		gohelper.addUIClickAudio(var_7_0.btn.gameObject, AudioEnum.WeekWalk.play_artificial_ui_checkpointswitch)

		arg_7_0._tabItems[arg_7_1] = var_7_0
	end

	return var_7_0
end

function var_0_0.onClickTab(arg_8_0, arg_8_1)
	Season123EnemyController.instance:switchTab(arg_8_1)
end

function var_0_0.refreshSelect(arg_9_0)
	local var_9_0 = Season123EnemyModel.instance:getBattleIds()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = arg_9_0:getOrCreateTabItem(iter_9_0)
		local var_9_2 = Season123EnemyModel.instance.selectIndex == iter_9_0

		gohelper.setActive(var_9_1.selectIcon, var_9_2)

		if var_9_2 then
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.txt, "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.imageStar1, "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.imageStar2, "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.txt, "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.imageStar1, "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.imageStar2, "#C1C5B6")
		end

		if var_9_1.imageStar3 then
			SLFramework.UGUI.GuiHelper.SetColor(var_9_1.imageStar3, var_9_2 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

return var_0_0
