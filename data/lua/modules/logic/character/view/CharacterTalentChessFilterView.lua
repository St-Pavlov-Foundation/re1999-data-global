module("modules.logic.character.view.CharacterTalentChessFilterView", package.seeall)

slot0 = class("CharacterTalentChessFilterView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closefilterview")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/#go_item")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/#go_item/#go_select")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/#go_item/#go_locked")
	slot0._txtstylename = gohelper.findChildText(slot0.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#txt_stylename")
	slot0._gocareer = gohelper.findChild(slot0.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#go_career")
	slot0._txtlabel = gohelper.findChildText(slot0.viewGO, "container/Scroll View/Viewport/Content/#go_item/layout/#go_career/#txt_label")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btnclosefilterviewOnClick, slot0)
	slot0:_addEvents()
end

function slot0.removeEvents(slot0)
	slot0._btnclosefilterview:RemoveClickListener()
	slot0:_removeEvents()
end

function slot0._btnclosefilterviewOnClick(slot0)
	slot0._animPlayer:Play("close", slot0.closeThis, slot0)
end

function slot0._editableInitView(slot0)
	slot0._txtTitleCn = gohelper.findChildText(slot0.viewGO, "container/title/dmgTypeCn")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "container/title/dmgTypeCn/dmgTypeEn")
	slot0._animPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._heroId = slot0.viewParam.heroId
	slot2 = CharacterEnum.TalentTxtByHeroType[HeroModel.instance:getByHeroId(slot0._heroId).config.heroType]
	slot0._txtTitleCn.text = luaLang("talent_style_title_cn_" .. slot2)
	slot0._txtTitleEn.text = luaLang("talent_style_title_en_" .. slot2)

	TalentStyleModel.instance:openView(slot0._heroId)
	slot0:_refreshVidew()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onUseTalentStyleReply, slot0)
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.onUseTalentStyleReply, slot0._onUseTalentStyleReply, slot0)
end

function slot0._onUseTalentStyleReply(slot0, slot1)
	slot0:_refreshVidew()
end

function slot0.onClickModalMask(slot0, slot1)
	slot0:closeThis()
end

function slot0._refreshVidew(slot0)
	TalentStyleListModel.instance:refreshData(slot0._heroId)
end

return slot0
