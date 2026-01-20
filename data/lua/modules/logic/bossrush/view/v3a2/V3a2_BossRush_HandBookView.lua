-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_HandBookView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_HandBookView", package.seeall)

local V3a2_BossRush_HandBookView = class("V3a2_BossRush_HandBookView", BaseView)

function V3a2_BossRush_HandBookView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._scrollboss = gohelper.findChildScrollRect(self.viewGO, "boss/#scroll_boss")
	self._gorank = gohelper.findChild(self.viewGO, "#go_rank")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_HandBookView:addEvents()
	self:addEventCb(BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, self._onSelectMonster, self)
	self:addEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_HandBookView:removeEvents()
	self:removeEventCb(BossRushController.instance, BossRushEvent.V3a2_BossRush_HandBook_SelectMonster, self._onSelectMonster, self)
	self:removeEventCb(BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_HandBookView:_onSelectMonster()
	self._anim:Play(V3a2BossRushEnum.AnimName.Switch, 0, 0)
	TaskDispatcher.cancelTask(self._onSelectMonsterCB, self)
	TaskDispatcher.runDelay(self._onSelectMonsterCB, self, 0.16)
end

function V3a2_BossRush_HandBookView:_onSelectMonsterCB()
	local mo = V3a2_BossRush_HandBookListModel.instance:getSelectMo()

	BossRushController.instance:dispatchEvent(BossRushEvent.V3a2_BossRush_HandBook_SelectMonsterCB, mo)
end

function V3a2_BossRush_HandBookView:_editableInitView()
	self._anim = self.viewGO:GetComponent(gohelper.Type_Animator)
end

function V3a2_BossRush_HandBookView:playRankBtnAnim()
	TaskDispatcher.cancelTask(self._playRankBtnAnimCB, self)
	TaskDispatcher.runDelay(self._playRankBtnAnimCB, self, 0.1)
end

function V3a2_BossRush_HandBookView:_playRankBtnAnimCB()
	if self._rankBtn then
		self._rankBtn:playAnim()
	end
end

function V3a2_BossRush_HandBookView:onOpen()
	V3a2_BossRush_HandBookListModel.instance:setMoList()
	self:_initRankBtn()
end

function V3a2_BossRush_HandBookView:onOpenFinish()
	self:_onSelectMonsterCB()
end

function V3a2_BossRush_HandBookView:_initRankBtn()
	local itemClass = V3a2_BossRush_RankBtn
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v3a2_bossrush_rankbtn, self._gorank, itemClass.__cname)

	self._rankBtn = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._rankBtn:refreshUI()
end

function V3a2_BossRush_HandBookView:onClose()
	return
end

function V3a2_BossRush_HandBookView:onDestroyView()
	TaskDispatcher.cancelTask(self._onSelectMonsterCB, self)
	TaskDispatcher.cancelTask(self._playRankBtnAnimCB, self)
end

return V3a2_BossRush_HandBookView
