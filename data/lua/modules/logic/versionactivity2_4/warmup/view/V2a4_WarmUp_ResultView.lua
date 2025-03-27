module("modules.logic.versionactivity2_4.warmup.view.V2a4_WarmUp_ResultView", package.seeall)

slot0 = class("V2a4_WarmUp_ResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagepanelbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_panelbg1")
	slot0._simagepanelbg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_panelbg2")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtfail = gohelper.findChildText(slot0.viewGO, "#go_fail/#txt_fail")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._txtsuccess = gohelper.findChildText(slot0.viewGO, "#go_success/#txt_success")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

slot1 = SLFramework.AnimatorPlayer

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._animPlayer = uv0.Get(slot0.viewGO)
end

function slot0.onUpdateParam(slot0)
	gohelper.setActive(slot0._gofail, not slot0:_isSucc())
	gohelper.setActive(slot0._gosuccess, slot0:_isSucc())

	slot0._txtsuccess.text = slot0:_desc()
	slot0._txtfail.text = slot0:_desc()
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	slot0._animPlayer:Play(slot0:_isSucc() and "success" or "fail", nil, )
	AudioMgr.instance:trigger(slot0:_isSucc() and AudioEnum.UI.play_ui_diqiu_yure_success_20249043 or AudioEnum.UI.play_ui_mln_remove_effect_20249042)
end

function slot0.onClose(slot0)
	slot0:_callCloseCallback()
end

function slot0.onDestroyView(slot0)
end

function slot0._isSucc(slot0)
	return slot0.viewParam.isSucc
end

function slot0._desc(slot0)
	return slot0.viewParam.desc
end

function slot0._callCloseCallback(slot0)
	if slot0.viewParam.closeCb then
		slot1(slot0.viewParam.closeCbObj)
	end
end

return slot0
