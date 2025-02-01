module("modules.logic.rouge.map.view.choicebase.RougeMapChoiceBaseItem", package.seeall)

slot0 = class("RougeMapChoiceBaseItem", UserDataDispose)

function slot0.init(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.tr = slot1:GetComponent(gohelper.Type_RectTransform)

	slot0:_editableInitView()
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.go)

	slot0.click:AddClickListener(slot0.onClickSelf, slot0)

	slot0.animator = slot0.go:GetComponent(gohelper.Type_Animator)
	slot0._golocked = gohelper.findChild(slot0.go, "#go_locked")
	slot0._txtlocktitle = gohelper.findChildText(slot0.go, "#go_locked/#txt_locktitle")
	slot0._txtlockdesc = gohelper.findChildText(slot0.go, "#go_locked/#txt_lockdesc")
	slot0._txtlocktip = gohelper.findChildText(slot0.go, "#go_locked/#txt_locktip")
	slot0._golockdetail = gohelper.findChild(slot0.go, "#go_locked/#btn_lockdetail")
	slot0._golockdetail2 = gohelper.findChild(slot0.go, "#go_locked/#btn_lockdetail2")
	slot0.goLockTip = slot0._txtlocktip.gameObject
	slot0._gonormal = gohelper.findChild(slot0.go, "#go_normal")
	slot0._txtnormaltitle = gohelper.findChildText(slot0.go, "#go_normal/#txt_normaltitle")
	slot0._txtnormaldesc = gohelper.findChildText(slot0.go, "#go_normal/#txt_normaldesc")
	slot0._txtnormaltip = gohelper.findChildText(slot0.go, "#go_normal/#txt_normaltip")
	slot0._gonormaldetail = gohelper.findChild(slot0.go, "#go_normal/#btn_normaldetail")
	slot0._gonormaldetail2 = gohelper.findChild(slot0.go, "#go_normal/#btn_normaldetail2")
	slot0._goselect = gohelper.findChild(slot0.go, "#go_select")
	slot0._txtselecttitle = gohelper.findChildText(slot0.go, "#go_select/#txt_selecttitle")
	slot0._txtselectdesc = gohelper.findChildText(slot0.go, "#go_select/#txt_selectdesc")
	slot0._txtselecttip = gohelper.findChildText(slot0.go, "#go_select/#txt_selecttip")
	slot0._goselectdetail = gohelper.findChild(slot0.go, "#go_select/#btn_selectdetail")
	slot0._goselectdetail2 = gohelper.findChild(slot0.go, "#go_select/#btn_selectdetail2")

	gohelper.setActive(slot0._golockdetail, false)
	gohelper.setActive(slot0._golockdetail2, false)
	gohelper.setActive(slot0._gonormaldetail, false)
	gohelper.setActive(slot0._goselectdetail, false)
	gohelper.setActive(slot0._gonormaldetail2, false)
	gohelper.setActive(slot0._goselectdetail2, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onChoiceItemStatusChange, slot0.onStatusChange, slot0)
end

function slot0.onStatusChange(slot0, slot1)
end

function slot0.onClickSelf(slot0)
end

function slot0.onSelectAnimDone(slot0)
end

function slot0.update(slot0, slot1)
	recthelper.setAnchor(slot0.tr, slot1.x, slot1.y)
end

function slot0.canShowNormalUI(slot0)
	return slot0.status == RougeMapEnum.ChoiceStatus.Normal or slot0.status == RougeMapEnum.ChoiceStatus.UnSelect
end

function slot0.canShowLockUI(slot0)
	return slot0.status == RougeMapEnum.ChoiceStatus.Lock
end

function slot0.canShowSelectUI(slot0)
	return slot0.status == RougeMapEnum.ChoiceStatus.Select
end

function slot0.refreshUI(slot0)
	slot0:refreshLockUI()
	slot0:refreshNormalUI()
	slot0:refreshSelectUI()
end

function slot0.refreshLockUI(slot0)
	slot1 = slot0:canShowLockUI()

	gohelper.setActive(slot0._golocked, slot1)

	if slot1 then
		slot0._txtlocktitle.text = slot0.title
		slot0._txtlockdesc.text = slot0.desc
		slot0._txtlocktip.text = slot0.tip

		gohelper.setActive(slot0.goLockTip, not string.nilorempty(slot0.tip))
	end
end

function slot0.refreshNormalUI(slot0)
	slot1 = slot0:canShowNormalUI()

	gohelper.setActive(slot0._gonormal, slot1)

	if slot1 then
		slot0._txtnormaltitle.text = slot0.title
		slot0._txtnormaldesc.text = slot0.desc
		slot0._txtnormaltip.text = slot0.tip

		if slot0.status == RougeMapEnum.ChoiceStatus.Normal then
			slot0.animator:Play("normal", 0, 0)
		else
			slot0.animator:Play("unselect", 0, 0)
		end
	end
end

function slot0.refreshSelectUI(slot0)
	slot1 = slot0:canShowSelectUI()

	gohelper.setActive(slot0._goselect, slot1)

	if slot1 then
		slot0._txtselecttitle.text = slot0.title
		slot0._txtselectdesc.text = slot0.desc
		slot0._txtselecttip.text = slot0.tip
	end
end

function slot0.clearCallback(slot0)
	if slot0.callbackId then
		RougeRpc.instance:removeCallbackById(slot0.callbackId)

		slot0.callbackId = nil
	end
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0.onSelectAnimDone, slot0)
	slot0.click:RemoveClickListener()
	slot0:clearCallback()
	slot0:__onDispose()
end

return slot0
