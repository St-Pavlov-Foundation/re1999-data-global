module("modules.logic.explore.view.ExploreFinishView", package.seeall)

local var_0_0 = class("ExploreFinishView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gohorizontal = gohelper.findChild(arg_1_0.viewGO, "center/progressbar/content")
	arg_1_0._txtchapter = gohelper.findChildTextMesh(arg_1_0.viewGO, "center/bg/#txt_chaptername")
	arg_1_0._txtchapterEn = gohelper.findChildTextMesh(arg_1_0.viewGO, "center/bg/#txt_chapternameen")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "center/progressbar/content/#go_item")

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
	AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerArrive)

	local var_5_0 = ExploreModel.instance:getMapId()
	local var_5_1 = ExploreConfig.instance:getMapIdConfig(var_5_0)
	local var_5_2 = DungeonConfig.instance:getEpisodeCO(var_5_1.episodeId)

	arg_5_0._txtchapter.text = var_5_2.name
	arg_5_0._txtchapterEn.text = var_5_2.name_En

	local var_5_3, var_5_4, var_5_5, var_5_6, var_5_7, var_5_8 = ExploreSimpleModel.instance:getCoinCountByMapId(var_5_0)
	local var_5_9 = {
		{
			var_5_5,
			var_5_8,
			"dungeon_secretroom_btn_triangle"
		},
		{
			var_5_4,
			var_5_7,
			"dungeon_secretroom_btn_sandglass"
		},
		{
			var_5_3,
			var_5_6,
			"dungeon_secretroom_btn_box"
		}
	}

	gohelper.CreateObjList(arg_5_0, arg_5_0.setItem, var_5_9, arg_5_0._gohorizontal, arg_5_0._goitem)
end

function var_0_0.setItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.findChildImage(arg_6_1, "bg2")
	local var_6_1 = gohelper.findChildImage(arg_6_1, "bg2/image_icon")
	local var_6_2 = gohelper.findChildTextMesh(arg_6_1, "txt_progress")
	local var_6_3 = arg_6_2[1] == arg_6_2[2]

	UISpriteSetMgr.instance:setExploreSprite(var_6_0, var_6_3 and "dungeon_secretroom_img_full" or "dungeon_secretroom_img_unfull")
	UISpriteSetMgr.instance:setExploreSprite(var_6_1, arg_6_2[3] .. (var_6_3 and "1" or "2"))

	local var_6_4 = var_6_3 and "E0BB6D" or "D5D4BC"

	var_6_2.text = string.format("<color=#%s>%d/%d", var_6_4, arg_6_2[1], arg_6_2[2])
end

function var_0_0.onClose(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	ExploreController.instance:exit()
end

return var_0_0
