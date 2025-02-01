module("modules.logic.main.view.FeedBackView", package.seeall)

slot0 = class("FeedBackView", BaseView)

function slot0.onInitView(slot0)
	slot0._browserGo = gohelper.findChild(slot0.viewGO, "browser")
	slot0._rootGo = gohelper.findChild(slot0.viewGO, "root")
	slot0._gosuretip = gohelper.findChild(slot0.viewGO, "root/bottom/#go_suretip")
	slot0._txtsuretip = gohelper.findChildText(slot0.viewGO, "root/bottom/#go_suretip")
	slot0._btnsure = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/bottom/#btn_sure")
	slot0._inputfeedback = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/message/#input_feedback")
	slot0._inputtitle = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/#input_title")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnsure:AddClickListener(slot0._btnsureOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._inputfeedback:AddOnValueChanged(slot0._onContentValueChanged, slot0)
	slot0._inputtitle:AddOnValueChanged(slot0._onTitleValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnsure:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._inputfeedback:RemoveOnValueChanged()
	slot0._inputtitle:RemoveOnValueChanged()
end

slot0.commitInterval = 30
slot0.maxTitleLength = 20
slot0.maxContentLength = 300
slot0.nilTitleToastId = 124
slot0.nilContentToastId = 125
slot0.maxTitleToastId = 126
slot0.maxContentToastId = 127

function slot0._btnsureOnClick(slot0)
	if string.nilorempty(slot0._inputtitle:GetText()) and string.nilorempty(slot0._inputfeedback:GetText()) then
		return
	end

	if string.nilorempty(slot1) then
		GameFacade.showToast(uv0.nilTitleToastId)

		return
	end

	if string.nilorempty(slot2) then
		GameFacade.showToast(uv0.nilContentToastId)

		return
	end

	TaskDispatcher.cancelTask(slot0.hideSureTip, slot0)

	if PlayerModel.instance:getPreFeedBackTime() == -1 or uv0.commitInterval < Time.time - slot3 then
		slot0:sendRequest(slot1, slot2)
		PlayerModel.instance:setPreFeedBackTime()
	else
		slot0._txtsuretip.text = luaLang("frequently_commit")

		gohelper.setActive(slot0._gosuretip, true)
		TaskDispatcher.runDelay(slot0.hideSureTip, slot0, 3)
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.sendRequest(slot0, slot1, slot2)
	slot4 = {}

	table.insert(slot4, string.format("userId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(slot4, string.format("title=%s", slot1))
	table.insert(slot4, string.format("content=%s", slot2))

	slot3 = GameUrlConfig.getCurConfig().feedBack .. "?" .. table.concat(slot4, "&")

	logWarn(slot3)
	SLFramework.SLWebRequest.Instance:Get(slot3, slot0.receiveResponse, slot0)
end

function slot0.receiveResponse(slot0, slot1, slot2)
	if slot2 == "fail" then
		slot0._txtsuretip.text = luaLang("frequently_commit")
	else
		slot0._txtsuretip.text = luaLang("thanks_feedback")

		slot0._inputfeedback:SetText("")
		slot0._inputtitle:SetText("")
	end

	gohelper.setActive(slot0._gosuretip, true)
	TaskDispatcher.runDelay(slot0.hideSureTip, slot0, 3)
end

function slot0._onContentValueChanged(slot0)
	if uv0.maxContentLength < string.utf8len(slot0._inputfeedback:GetText()) then
		slot0._inputfeedback:SetText(GameUtil.utf8sub(slot1, 1, uv0.maxContentLength))
		GameFacade.showToast(uv0.maxContentToastId, uv0.maxContentLength)
	end
end

function slot0._onTitleValueChanged(slot0)
	if uv0.maxTitleLength < string.utf8len(slot0._inputtitle:GetText()) then
		slot0._inputtitle:SetText(GameUtil.utf8sub(slot1, 1, uv0.maxTitleLength))
		GameFacade.showToast(uv0.maxTitleToastId, uv0.maxTitleLength)
	end
end

function slot0.hideSureTip(slot0)
	gohelper.setActive(slot0._gosuretip, false)
end

function slot0._editableInitView(slot0)
	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.play_ui_feedback_close)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if GameChannelConfig.isSlsdk() then
		slot0:hideSureTip()
		gohelper.setActive(slot0._browserGo, false)
		gohelper.setActive(slot0._rootGo, true)
	else
		gohelper.setActive(slot0._browserGo, true)
		gohelper.setActive(slot0._rootGo, false)
	end

	NavigateMgr.instance:addEscape(ViewName.FeedBackView, slot0._btncloseOnClick, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
