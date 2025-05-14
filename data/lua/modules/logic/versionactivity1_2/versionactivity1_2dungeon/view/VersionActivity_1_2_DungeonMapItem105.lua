module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapItem105", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapItem105", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gorewarditem = gohelper.findChild(arg_1_0.viewGO, "rotate/layout/top/reward/#go_rewarditem")
	arg_1_0._txttitle = gohelper.findChildText(arg_1_0.viewGO, "rotate/layout/top/title/#txt_title")
	arg_1_0._gopickupbg = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_pickupbg")
	arg_1_0._gopickup = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_pickupbg/#go_pickup")
	arg_1_0._txtcontent = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_pickupbg/#go_pickup/#txt_content")
	arg_1_0._goop = gohelper.findChild(arg_1_0.viewGO, "rotate/#go_op")
	arg_1_0._txtdoit = gohelper.findChildText(arg_1_0.viewGO, "rotate/#go_op/bg/#txt_doit")
	arg_1_0._btndoit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rotate/#go_op/bg/#btn_doit")
	arg_1_0._simagebgimag = gohelper.findChildSingleImage(arg_1_0.viewGO, "rotate/#go_pickupbg/bgimag")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndoit:AddClickListener(arg_2_0._btndoitOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.closeChildElementView, arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndoit:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_onBtnCloseSelf()
end

function var_0_0._onBtnCloseSelf(arg_5_0)
	SLFramework.AnimatorPlayer.Get(arg_5_0.viewGO):Play("close", arg_5_0.DESTROYSELF, arg_5_0)
end

function var_0_0._btndoitOnClick(arg_6_0)
	if arg_6_0._finishedFight then
		DungeonRpc.instance:sendMapElementRequest(arg_6_0._config.id)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	else
		local var_6_0 = tonumber(arg_6_0._config.param)

		DungeonModel.instance.curLookEpisodeId = var_6_0

		if TeachNoteModel.instance:isTeachNoteEpisode(var_6_0) then
			TeachNoteController.instance:enterTeachNoteDetailView(var_6_0)
		else
			local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)

			DungeonFightController.instance:enterFight(var_6_1.chapterId, var_6_0)
		end

		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_continuemesh)
	end

	arg_6_0:DESTROYSELF()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebgimag:LoadImage(ResUrl.getVersionActivityDungeon_1_2("tanchaung_di"))
end

function var_0_0.onRefreshViewParam(arg_8_0, arg_8_1)
	arg_8_0._config = arg_8_1
end

function var_0_0.onOpen(arg_9_0)
	local var_9_0 = tonumber(arg_9_0._config.param)

	arg_9_0._finishedFight = DungeonModel.instance:hasPassLevel(var_9_0)

	if arg_9_0._finishedFight then
		arg_9_0._txtcontent.text = arg_9_0._config.finishText
		arg_9_0._txtdoit.text = luaLang("confirm_text")
	else
		arg_9_0._txtcontent.text = arg_9_0._config.desc
		arg_9_0._txtdoit.text = arg_9_0._config.acceptText
	end

	arg_9_0._txttitle.text = arg_9_0._config.title
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebgimag:UnLoadImage()
end

return var_0_0
