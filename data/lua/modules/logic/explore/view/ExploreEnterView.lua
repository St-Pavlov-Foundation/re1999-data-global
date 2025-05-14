module("modules.logic.explore.view.ExploreEnterView", package.seeall)

local var_0_0 = class("ExploreEnterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")
	arg_1_0._txtnamecn = gohelper.findChildTextMesh(arg_1_0.viewGO, "center/#txt_namecn")
	arg_1_0._imagenum = gohelper.findChildImage(arg_1_0.viewGO, "center/bg/#image_num")
	arg_1_0._txtlevelname = gohelper.findChildTextMesh(arg_1_0.viewGO, "center/bg/#txt_levelname")
	arg_1_0._gohorizontal = gohelper.findChild(arg_1_0.viewGO, "center/progressbar/horizontal")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "center/progressbar/horizontal/#go_item")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

	local var_5_0 = ExploreModel.instance:getMapId()
	local var_5_1 = ExploreConfig.instance:getMapIdConfig(var_5_0)
	local var_5_2 = DungeonConfig.instance:getExploreChapterList()
	local var_5_3 = 1

	for iter_5_0, iter_5_1 in ipairs(var_5_2) do
		if iter_5_1.id == var_5_1.chapterId then
			var_5_3 = iter_5_0

			break
		end
	end

	local var_5_4 = var_5_2[var_5_3].name
	local var_5_5 = GameUtil.utf8len(var_5_4)
	local var_5_6

	if var_5_5 >= 2 then
		local var_5_7 = GameUtil.utf8sub(var_5_4, 1, 1)
		local var_5_8 = GameUtil.utf8sub(var_5_4, 2, var_5_5 - 2)
		local var_5_9 = GameUtil.utf8sub(var_5_4, var_5_5, 1)

		var_5_6 = string.format("<size=50>%s</size>%s<size=50>%s</size>", var_5_7, var_5_8, var_5_9)
	else
		var_5_6 = "<size=50>" .. var_5_4
	end

	arg_5_0._txtnamecn.text = var_5_6

	local var_5_10 = DungeonConfig.instance:getChapterEpisodeCOList(var_5_2[var_5_3].id)
	local var_5_11 = 1

	for iter_5_2, iter_5_3 in ipairs(var_5_10) do
		if iter_5_3.id == var_5_1.episodeId then
			var_5_11 = iter_5_2

			break
		end
	end

	UISpriteSetMgr.instance:setExploreSprite(arg_5_0._imagenum, "dungeon_secretroom_num_" .. var_5_11)

	arg_5_0._txtlevelname.text = var_5_10[var_5_11].name

	local var_5_12, var_5_13, var_5_14, var_5_15, var_5_16, var_5_17 = ExploreSimpleModel.instance:getCoinCountByMapId(var_5_0)
	local var_5_18 = {
		{
			var_5_14,
			var_5_17,
			"dungeon_secretroom_btn_triangle"
		},
		{
			var_5_13,
			var_5_16,
			"dungeon_secretroom_btn_sandglass"
		},
		{
			var_5_12,
			var_5_15,
			"dungeon_secretroom_btn_box"
		}
	}

	gohelper.CreateObjList(arg_5_0, arg_5_0.setItem, var_5_18, arg_5_0._gohorizontal, arg_5_0._goitem)
	TaskDispatcher.runDelay(arg_5_0.closeThis, arg_5_0, 3)
end

function var_0_0.setItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildImage(arg_6_1, "bg")
	local var_6_1 = gohelper.findChildImage(arg_6_1, "image_icon")
	local var_6_2 = gohelper.findChildTextMesh(arg_6_1, "txt_progress")

	UISpriteSetMgr.instance:setExploreSprite(var_6_0, arg_6_2[1] == arg_6_2[2] and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	UISpriteSetMgr.instance:setExploreSprite(var_6_1, arg_6_2[3] .. (arg_6_2[1] == arg_6_2[2] and "1" or "2"))

	var_6_2.text = string.format("%d/%d", arg_6_2[1], arg_6_2[2])
end

function var_0_0.onClose(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	TaskDispatcher.cancelTask(arg_7_0.closeThis, arg_7_0)

	local var_7_0 = ExploreController.instance:getMap()

	if not var_7_0 then
		return
	end

	var_7_0:getHero():onRoleFirstEnter()
end

return var_0_0
