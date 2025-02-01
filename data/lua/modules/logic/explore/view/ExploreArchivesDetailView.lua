module("modules.logic.explore.view.ExploreArchivesDetailView", package.seeall)

slot0 = class("ExploreArchivesDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnclose2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close2")
	slot0._txttitle = gohelper.findChildTextMesh(slot0.viewGO, "#txt_title")
	slot0._txtinfo = gohelper.findChildTextMesh(slot0.viewGO, "mask/#txt_info")
	slot0._txtdec = gohelper.findChildTextMesh(slot0.viewGO, "mask/Scroll View/Viewport/Content/#txt_dec")
	slot1 = slot0._txtinfo.gameObject
	slot0._tmpMarkTopText = MonoHelper.addNoUpdateLuaComOnceToGo(slot1, TMPMarkTopText)

	slot0._tmpMarkTopText:setTopOffset(0, -2.6)
	slot0._tmpMarkTopText:setLineSpacing(31)
	slot0._tmpMarkTopText:registerRebuildLayout(slot1.transform.parent)

	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnclose2:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclose2:RemoveClickListener()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_open)

	slot1 = lua_explore_story.configDict[slot0.viewParam.chapterId][slot0.viewParam.id]
	slot2 = slot1.title
	slot0._txttitle.text = string.format("<size=50>%s</size>%s", GameUtil.utf8sub(slot2, 1, 1), GameUtil.utf8sub(slot2, 2, #slot2))

	slot0._tmpMarkTopText:setData(slot1.desc)

	slot0._txtdec.text = slot1.content

	slot0._simageicon:LoadImage(ResUrl.getExploreBg("file/" .. slot1.res))
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	GameUtil.onDestroyViewMember(slot0, "_tmpMarkTopText")
	slot0._simageicon:UnLoadImage()
end

return slot0
