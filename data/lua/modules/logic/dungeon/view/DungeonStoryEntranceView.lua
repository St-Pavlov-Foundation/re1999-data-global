module("modules.logic.dungeon.view.DungeonStoryEntranceView", package.seeall)

local var_0_0 = class("DungeonStoryEntranceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnblack = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_black")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_play")
	arg_1_0._txtchapter = gohelper.findChildText(arg_1_0.viewGO, "#txt_chapter")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "#txt_nameen")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnblack:AddClickListener(arg_2_0._btnblackOnClick, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnblack:RemoveClickListener()
	arg_3_0._btnplay:RemoveClickListener()
end

function var_0_0._btnblackOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnplayOnClick(arg_5_0)
	DungeonRpc.instance:sendStartDungeonRequest(arg_5_0._config.chapterId, arg_5_0._config.id)

	local var_5_0 = {}

	var_5_0.mark = true
	var_5_0.episodeId = arg_5_0._config.id

	StoryController.instance:playStory(arg_5_0._config.beforeStory, var_5_0, arg_5_0.onStoryFinished, arg_5_0)
end

function var_0_0.onStoryFinished(arg_6_0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(arg_6_0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(arg_6_0.viewName)
end

function var_0_0._editableInitView(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copiesdetails)
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._config = arg_9_0.viewParam[1]
	arg_9_0._txtname.text = arg_9_0._config.name
	arg_9_0._txtnameen.text = arg_9_0._config.name_En
	arg_9_0._txtdesc.text = arg_9_0._config.desc

	DungeonLevelItem.showEpisodeName(arg_9_0._config, arg_9_0.viewParam[3], arg_9_0.viewParam[4], arg_9_0._txtchapter)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
