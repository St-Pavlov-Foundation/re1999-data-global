-- chunkname: @modules/logic/survival/view/leavemessage/item/SurvivalLeaveMsgItem.lua

module("modules.logic.survival.view.leavemessage.item.SurvivalLeaveMsgItem", package.seeall)

local SurvivalLeaveMsgItem = class("SurvivalLeaveMsgItem", SimpleListItem)

function SurvivalLeaveMsgItem:onInit()
	self.bgOthers = gohelper.findChild(self.viewGO, "go_bg/others")
	self.myself = gohelper.findChild(self.viewGO, "go_bg/myself")
	self.textName = gohelper.findChildTextMesh(self.viewGO, "#txt_Author")
	self.textContent = gohelper.findChildTextMesh(self.viewGO, "#txt_Content")
	self.textNum = gohelper.findChildTextMesh(self.viewGO, "#txt_Num")
	self.txt_Num_unLike = gohelper.findChildTextMesh(self.viewGO, "#txt_Num_unLike")
	self.btnLike = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Like")
	self.likeSelect = gohelper.findChild(self.btnLike.gameObject, "selected")
	self.btnLikeAnim = self.likeSelect:GetComponent("Animator")
	self.btnUnLike = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_UnLike")
	self.btn_delete = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_delete")
	self.unlikeSelect = gohelper.findChild(self.btnUnLike.gameObject, "selected")
	self.btnUnLikeAnim = self.unlikeSelect:GetComponent("Animator")
end

function SurvivalLeaveMsgItem:onAddListeners()
	self:addClickCb(self.btnLike, self.onClickBtnLike, self)
	self:addClickCb(self.btnUnLike, self.onClickBtnUnLike, self)
	self:addClickCb(self.btn_delete, self.onClickBtnDelete, self)
end

function SurvivalLeaveMsgItem:onClickBtnLike()
	if self.survivalMessage.status == 1 then
		SurvivalInteriorRpc.instance:sendSurvivalMessageOperationRequest(self.unitId, self.survivalMessage.id, SurvivalEnum.LeaveMsgOptType.CancelLike)
	else
		SurvivalInteriorRpc.instance:sendSurvivalMessageOperationRequest(self.unitId, self.survivalMessage.id, SurvivalEnum.LeaveMsgOptType.Like)
	end
end

function SurvivalLeaveMsgItem:onClickBtnUnLike()
	if self.survivalMessage.status == 2 then
		SurvivalInteriorRpc.instance:sendSurvivalMessageOperationRequest(self.unitId, self.survivalMessage.id, SurvivalEnum.LeaveMsgOptType.CancelUnLike)
	else
		SurvivalInteriorRpc.instance:sendSurvivalMessageOperationRequest(self.unitId, self.survivalMessage.id, SurvivalEnum.LeaveMsgOptType.UnLike)
	end
end

function SurvivalLeaveMsgItem:onClickBtnDelete()
	SurvivalInteriorRpc.instance:sendSurvivalMessageOperationRequest(self.unitId, self.survivalMessage.id, SurvivalEnum.LeaveMsgOptType.Delete)
end

function SurvivalLeaveMsgItem:onItemShow(data)
	self.unitId = data.unitId
	self.survivalMessage = data.survivalMessage

	self:getRootAnimatorPlayer():Play("idle", nil, nil)
	self:refresh()
	gohelper.setActive(self.btn_delete.gameObject, self.survivalMessage.isSelf)

	local ids = SurvivalConfig.instance:switchServerMessage(self.survivalMessage.configId)

	self.textContent.text = SurvivalConfig.instance:getMessageByIds(ids)

	if self.survivalMessage.isSelf then
		self.textName.text = luaLang("SurvivalLeaveMsgItem_1")
	else
		self.textName.text = luaLang("SurvivalLeaveMsgItem_2")
	end

	gohelper.setActive(self.bgOthers, not self.survivalMessage.isSelf)
	gohelper.setActive(self.myself, self.survivalMessage.isSelf)
end

function SurvivalLeaveMsgItem:playLikeAnim()
	self.btnLikeAnim:Play("select")
end

function SurvivalLeaveMsgItem:playUnLikeAnim()
	self.btnUnLikeAnim:Play("select")
end

function SurvivalLeaveMsgItem:refresh()
	self.textNum.text = self.survivalMessage.likeCount
	self.txt_Num_unLike.text = self.survivalMessage.dislikeCount or 0

	gohelper.setActive(self.likeSelect, self.survivalMessage.status == 1)
	gohelper.setActive(self.unlikeSelect, self.survivalMessage.status == 2)
end

return SurvivalLeaveMsgItem
