module("modules.logic.rouge.view.RougeEndingThreeView", package.seeall)

slot0 = class("RougeEndingThreeView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnnext = gohelper.findChildButton(slot0.viewGO, "Content/#btn_next")
	slot0._txtcontent = gohelper.findChildText(slot0.viewGO, "Content/#go_success/txt_success")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "Content/Title/#txt_Title")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnnext:RemoveClickListener()
end

function slot0._btnnextOnClick(slot0)
	slot0:closeThis()
	RougeController.instance:openRougeResultView()
end

function slot0._editableInitView(slot0)
	slot0._txttitle.text = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeTitle] and slot1.value2
	slot0._txtcontent.text = lua_rouge_const.configDict[RougeEnum.Const.EndingThreeContent] and slot3.value2
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenEndingThreeView)
end

return slot0
