module("modules.logic.dungeon.view.DungeonStoryEntranceView", package.seeall)

slot0 = class("DungeonStoryEntranceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnblack = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_black")
	slot0._btnplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_play")
	slot0._txtchapter = gohelper.findChildText(slot0.viewGO, "#txt_chapter")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#txt_nameen")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnblack:AddClickListener(slot0._btnblackOnClick, slot0)
	slot0._btnplay:AddClickListener(slot0._btnplayOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnblack:RemoveClickListener()
	slot0._btnplay:RemoveClickListener()
end

function slot0._btnblackOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnplayOnClick(slot0)
	DungeonRpc.instance:sendStartDungeonRequest(slot0._config.chapterId, slot0._config.id)
	StoryController.instance:playStory(slot0._config.beforeStory, {
		mark = true,
		episodeId = slot0._config.id
	}, slot0.onStoryFinished, slot0)
end

function slot0.onStoryFinished(slot0)
	DungeonModel.instance.curSendEpisodeId = nil

	DungeonModel.instance:setLastSendEpisodeId(slot0._config.id)
	DungeonRpc.instance:sendEndDungeonRequest(false)
	ViewMgr.instance:closeView(slot0.viewName)
end

function slot0._editableInitView(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copiesdetails)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._config = slot0.viewParam[1]
	slot0._txtname.text = slot0._config.name
	slot0._txtnameen.text = slot0._config.name_En
	slot0._txtdesc.text = slot0._config.desc

	DungeonLevelItem.showEpisodeName(slot0._config, slot0.viewParam[3], slot0.viewParam[4], slot0._txtchapter)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
