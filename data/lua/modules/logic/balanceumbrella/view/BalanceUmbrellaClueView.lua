module("modules.logic.balanceumbrella.view.BalanceUmbrellaClueView", package.seeall)

slot0 = class("BalanceUmbrellaClueView", BaseView)

function slot0.onInitView(slot0)
	slot0._goget = gohelper.findChild(slot0.viewGO, "#go_get")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_detail")
	slot0._animget = slot0._goget:GetComponent(typeof(UnityEngine.Animator))
	slot0._animdetail = slot0._godetail:GetComponent(typeof(UnityEngine.Animator))
	slot0._btngetClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_get/#btn_close")
	slot0._simagegetclue = gohelper.findChildSingleImage(slot0.viewGO, "#go_get/#simage_clue")
	slot0._btndetailclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_close")
	slot0._simagedetailclue = gohelper.findChildSingleImage(slot0.viewGO, "#go_detail/Left/#simage_clue")
	slot0._txtroledesc = gohelper.findChildTextMesh(slot0.viewGO, "#go_detail/Right/#scroll_desc/viewport/content/#txt_dec")
	slot0._txtdesc = gohelper.findChildTextMesh(slot0.viewGO, "#go_detail/Right/#scroll_desc/viewport/content/#txt_cluedec")
	slot0._txtname = gohelper.findChildTextMesh(slot0.viewGO, "#go_detail/Right/titlebg/#txt_cluename")
end

function slot0.addEvents(slot0)
	slot0._btngetClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btndetailclose:AddClickListener(slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngetClose:RemoveClickListener()
	slot0._btndetailclose:RemoveClickListener()
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._goget, slot0.viewParam.isGet)
	gohelper.setActive(slot0._godetail, not slot0.viewParam.isGet)
	slot0._simagegetclue:LoadImage(string.format("singlebg/balance_singlebg/item/balance_bigitem_%02d.png", slot0.viewParam.id))
	slot0._simagedetailclue:LoadImage(string.format("singlebg/balance_singlebg/item/balance_bigitem_%02d.png", slot0.viewParam.id))

	if not lua_balance_umbrella.configDict[slot0.viewParam.id] then
		return
	end

	slot0._txtname.text = slot1.name
	slot0._txtdesc.text = slot1.desc
	slot0._txtroledesc.text = slot1.players

	if slot0.viewParam.isGet then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_season_succeed)
		UIBlockHelper.instance:startBlock("BalanceUmbrellaClueView_Get", 1, slot0.viewName)
		TaskDispatcher.runDelay(slot0._showDetail, slot0, 1)
		slot0._animget:Play("open", 0, 0)
	else
		slot0._animdetail:Play("open", 0, 0)
	end
end

function slot0._showDetail(slot0)
	gohelper.setActive(slot0._godetail, true)
	slot0._animget:Play("close", 0, 0)
	slot0._animdetail:Play("switch", 0, 0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	if slot0.viewParam.isGet then
		BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.ShowGetEffect)
	end
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._showDetail, slot0)
	BalanceUmbrellaController.instance:dispatchEvent(BalanceUmbrellaEvent.GuideClueViewClose)
	slot0._simagegetclue:UnLoadImage()
	slot0._simagedetailclue:UnLoadImage()
end

return slot0
