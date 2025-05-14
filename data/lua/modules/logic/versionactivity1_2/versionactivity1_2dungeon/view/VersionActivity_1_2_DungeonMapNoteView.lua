module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapNoteView", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapNoteView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._simagebg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg3")
	arg_1_0._gopaper = gohelper.findChild(arg_1_0.viewGO, "content/#go_paper")
	arg_1_0._txtpapertitle = gohelper.findChildText(arg_1_0.viewGO, "content/#go_paper/#txt_papertitle")
	arg_1_0._txtpaperdesc = gohelper.findChildText(arg_1_0.viewGO, "content/#go_paper/#txt_papertitle/#txt_paperdesc")
	arg_1_0._gonotebook = gohelper.findChild(arg_1_0.viewGO, "content/#go_notebook")
	arg_1_0._btnclose = gohelper.getClick(arg_1_0.viewGO)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	arg_3_0._simagebg3:LoadImage(ResUrl.getYaXianImage("img_huode_bg"))
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_5_0)
	if arg_5_0._closed then
		return
	end

	SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO):Play("close", arg_5_0.closeThis, arg_5_0)

	arg_5_0._closed = true
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._closed = nil
	arg_6_0._activityId = VersionActivityEnum.ActivityId.Act121

	local var_6_0 = arg_6_0.viewParam and arg_6_0.viewParam.showBook
	local var_6_1 = arg_6_0.viewParam and arg_6_0.viewParam.showPaper

	gohelper.setActive(arg_6_0._gonotebook, var_6_0)
	gohelper.setActive(arg_6_0._gopaper, var_6_1)

	if var_6_1 then
		local var_6_2 = lua_activity121_note.configDict[arg_6_0.viewParam.id][arg_6_0._activityId]

		arg_6_0._txtpapertitle.text = var_6_2.name
		arg_6_0._txtpaperdesc.text = var_6_2.desc

		VersionActivity1_2NoteModel.instance:setNote(arg_6_0.viewParam.id)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_notebook_get)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_clue_get)
	end
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagebg1:UnLoadImage()
	arg_8_0._simagebg3:UnLoadImage()
end

return var_0_0
