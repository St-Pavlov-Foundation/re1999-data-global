module("modules.logic.teach.view.TeachNoteView", package.seeall)

slot0 = class("TeachNoteView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._simagefyleft = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fy/#simage_fyleft")
	slot0._simagefyright = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fy/#simage_fyright")
	slot0._gotopic = gohelper.findChild(slot0.viewGO, "#go_topic")
	slot0._gotopicitem = gohelper.findChild(slot0.viewGO, "#go_topic/#go_topicitem")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "#go_reward")
	slot0._scrollrewarditem = gohelper.findChildScrollRect(slot0.viewGO, "#go_reward/#scroll_rewarditem")
	slot0._gofinish = gohelper.findChild(slot0.viewGO, "#go_reward/#go_finish")
	slot0._simagerewardbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_reward/#go_finish/#simage_rewardbg1")
	slot0._btngetall = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_reward/#go_finish/#btn_getall")
	slot0._gorewarddetail = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail")
	slot0._btnrewarddetailclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_reward/#go_rewarddetail/#btn_rewarddetailclose")
	slot0._gocontentSize = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_contentSize")
	slot0._goitems = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_items")
	slot0._gorewarddetailItem = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_items/#go_rewarddetailItem")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_items/Viewport/Content/#go_rewardContent")
	slot0._goclickarea = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_items/Viewport/Content/#go_rewardContent/#go_clickarea")
	slot0._goitemex = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_itemex")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewarddetail/#go_itemex/#go_item")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reward")
	slot0._gorewardredpoint = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_rewardredpoint")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "#go_level")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "#go_level/#go_left")
	slot0._simagelefunlock = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#go_left/#simage_unlock")
	slot0._simagelefticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#go_left/#simage_lefticon")
	slot0._txtleftname = gohelper.findChildText(slot0.viewGO, "#go_level/#go_left/#txt_leftname")
	slot0._goleftpass = gohelper.findChild(slot0.viewGO, "#go_level/#go_left/#txt_leftname/#go_leftpass")
	slot0._goleftpassdone = gohelper.findChild(slot0.viewGO, "#go_level/#go_left/#txt_leftname/#go_leftpassdone")
	slot0._txtleftnameen = gohelper.findChildText(slot0.viewGO, "#go_level/#go_left/#txt_leftnameen")
	slot0._imageleftindex = gohelper.findChildImage(slot0.viewGO, "#go_level/#go_left/#image_leftindex")
	slot0._goleftnotetip = gohelper.findChild(slot0.viewGO, "#go_level/#go_left/#go_leftnotetip")
	slot0._txtleftnotedesc = gohelper.findChildText(slot0.viewGO, "#go_level/#go_left/#go_leftnotetip/#txt_leftnotedesc")
	slot0._goleftdescitem = gohelper.findChild(slot0.viewGO, "#go_level/#go_left/leftitemdescs/#go_leftdescitem")
	slot0._goleftunlock = gohelper.findChild(slot0.viewGO, "#go_level/#go_left/#go_leftunlock")
	slot0._btnleftlearn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn")
	slot0._goleftlock = gohelper.findChild(slot0.viewGO, "#go_level/#go_left/#go_leftlock")
	slot0._btnleftarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_level/#go_left/#btn_leftarrow")
	slot0._goright = gohelper.findChild(slot0.viewGO, "#go_level/#go_right")
	slot0._simagerightunlock = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#go_right/#simage_unlock")
	slot0._simagerighticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#go_right/#simage_righticon")
	slot0._txtrightname = gohelper.findChildText(slot0.viewGO, "#go_level/#go_right/#txt_rightname")
	slot0._gorightpass = gohelper.findChild(slot0.viewGO, "#go_level/#go_right/#txt_rightname/#go_leftpass")
	slot0._gorightpassdone = gohelper.findChild(slot0.viewGO, "#go_level/#go_right/#txt_rightname/#go_leftpassdone")
	slot0._txtrightnameen = gohelper.findChildText(slot0.viewGO, "#go_level/#go_right/#txt_rightnameen")
	slot0._imagerightindex = gohelper.findChildImage(slot0.viewGO, "#go_level/#go_right/#image_rightindex")
	slot0._gorightnotetip = gohelper.findChild(slot0.viewGO, "#go_level/#go_right/#go_rightnotetip")
	slot0._txtrightnotedesc = gohelper.findChildText(slot0.viewGO, "#go_level/#go_right/#go_rightnotetip/#txt_rightnotedesc")
	slot0._gorightdescitem = gohelper.findChild(slot0.viewGO, "#go_level/#go_right/rightitemdescs/#go_rightdescitem")
	slot0._gorightunlock = gohelper.findChild(slot0.viewGO, "#go_level/#go_right/#go_rightunlock")
	slot0._btnrightlearn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn")
	slot0._gorightlock = gohelper.findChild(slot0.viewGO, "#go_level/#go_right/#go_rightlock")
	slot0._btnrightarrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_level/#go_right/#btn_rightarrow")
	slot0._goend = gohelper.findChild(slot0.viewGO, "#go_level/#go_end")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._txtleftstartcn = gohelper.findChildText(slot0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn/#txt_leftstartcn")
	slot0._txtleftstarten = gohelper.findChildText(slot0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn/#txt_leftstarten")
	slot0._txtrightstartcn = gohelper.findChildText(slot0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn/#txt_rightstartcn")
	slot0._txtrightstarten = gohelper.findChildText(slot0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn/#txt_rightstarten")
	slot0._simageleftlockmask = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#go_left/#go_leftlock/#simage_leftlockmask")
	slot0._simagerightlockmask = gohelper.findChildSingleImage(slot0.viewGO, "#go_level/#go_right/#go_rightlock/#simage_rightlockmask")
	slot0._goreceivetip = gohelper.findChild(slot0.viewGO, "#go_reward/#go_finish/#go_receivetip")
	slot0._btnreward1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_reward/#go_finish/#go_reward1/click")
	slot0._btnreward2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_reward/#go_finish/#go_reward2/click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btngetall:AddClickListener(slot0._btngetallOnClick, slot0)
	slot0._btnrewarddetailclose:AddClickListener(slot0._btnrewarddetailcloseOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnleftlearn:AddClickListener(slot0._btnleftlearnOnClick, slot0)
	slot0._btnleftarrow:AddClickListener(slot0._btnleftarrowOnClick, slot0)
	slot0._btnrightlearn:AddClickListener(slot0._btnrightlearnOnClick, slot0)
	slot0._btnrightarrow:AddClickListener(slot0._btnrightarrowOnClick, slot0)
	slot0._btnreward1:AddClickListener(slot0._btnreward1OnClick, slot0)
	slot0._btnreward2:AddClickListener(slot0._btnreward2OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btngetall:RemoveClickListener()
	slot0._btnrewarddetailclose:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnleftlearn:RemoveClickListener()
	slot0._btnleftarrow:RemoveClickListener()
	slot0._btnrightlearn:RemoveClickListener()
	slot0._btnrightarrow:RemoveClickListener()
	slot0._btnreward1:RemoveClickListener()
	slot0._btnreward2:RemoveClickListener()
end

function slot0._btnleftarrowOnClick(slot0)
	slot0:_changeRight()
end

function slot0._btnrightarrowOnClick(slot0)
	slot0:_changeLeft()
end

function slot0._btnreward1OnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(7, 2)
end

function slot0._btnreward2OnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(1, 133023)
end

function slot0._btngetallOnClick(slot0)
	if not TeachNoteModel.instance:isTeachNoteFinalRewardCouldGet() then
		gohelper.setActive(slot0._gorewarddetail, true)
	else
		DungeonRpc.instance:sendInstructionDungeonFinalRewardRequest()
	end
end

function slot0._btnrewarddetailcloseOnClick(slot0)
	gohelper.setActive(slot0._gorewarddetail, false)
end

function slot0._btnrightlearnOnClick(slot0)
	slot3 = TeachNoteModel.instance:getTopicLevelCos(TeachNoteModel.instance:getTeachNoticeTopicId())[2 * slot0._tag + 2]

	if slot0.viewParam.isJump then
		TeachNoteModel.instance:setJumpEpisodeId(slot3.episodeId)
		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot3.episodeId).chapterId, slot3.episodeId)
	else
		DungeonModel.instance.curLookEpisodeId = slot3.episodeId

		TeachNoteModel.instance:setLevelEnterFightState(TeachNoteModel.instance:isTeachNoteLevelPass(slot3.id))
		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot3.episodeId).chapterId, slot3.episodeId)
	end
end

function slot0._btnleftlearnOnClick(slot0)
	slot3 = TeachNoteModel.instance:getTopicLevelCos(TeachNoteModel.instance:getTeachNoticeTopicId())[2 * slot0._tag + 1]

	if slot0.viewParam.isJump then
		TeachNoteModel.instance:setJumpEpisodeId(slot3.episodeId)
		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot3.episodeId).chapterId, slot3.episodeId)
	else
		DungeonModel.instance.curLookEpisodeId = slot3.episodeId

		TeachNoteModel.instance:setLevelEnterFightState(TeachNoteModel.instance:isTeachNoteLevelPass(slot3.id))
		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(DungeonConfig.instance:getEpisodeCO(slot3.episodeId).chapterId, slot3.episodeId)
	end
end

function slot0._btnrewardOnClick(slot0)
	if slot0._showReward then
		return
	end

	TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)

	slot0._showReward = true

	slot0:_refreshItem()
end

function slot0._editableInitView(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._simagebg.gameObject)
	slot0._gorewardBeSelected = gohelper.findChild(slot0.viewGO, "#btn_reward/beselected")
	slot0._gorewardUnselected = gohelper.findChild(slot0.viewGO, "#btn_reward/unselected")
	slot0._imageleftlearn = gohelper.findChildImage(slot0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn")
	slot0._imagerightlearn = gohelper.findChildImage(slot0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn")
	slot0._leftlockCanvas = slot0._goleftlock:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._rightlockCanvas = slot0._gorightlock:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(slot0._btnreward.gameObject, AudioEnum.TeachNote.play_ui_activity_switch)
	gohelper.addUIClickAudio(slot0._btngetall.gameObject, AudioEnum.TeachNote.play_ui_activity_act)
	gohelper.addUIClickAudio(slot0._btnleftlearn.gameObject, AudioEnum.TeachNote.play_ui_activity_jump)
	gohelper.addUIClickAudio(slot0._btnrightlearn.gameObject, AudioEnum.TeachNote.play_ui_activity_jump)
	gohelper.removeUIClickAudio(slot0._btnleftarrow.gameObject)
	gohelper.removeUIClickAudio(slot0._btnrightarrow.gameObject)
	slot0._simagebg:LoadImage(ResUrl.getTeachNoteImage("full/bg_jiaoxuebiji_beijingtu.jpg"))
	slot0._simagerewardbg1:LoadImage(ResUrl.getTeachNoteImage("bg_jianglixuanchuan.png"))
	slot0._simagelefunlock:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_kongdi.png"))
	slot0._simagerightunlock:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_kongdi.png"))
	slot0._simageleftlockmask:LoadImage(ResUrl.getTeachNoteImage("btn_zhezhao_1.png"))
	slot0._simagerightlockmask:LoadImage(ResUrl.getTeachNoteImage("btn_zhezhao.png"))

	slot0._viewAnim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._leftpassAni = slot0._txtleftname.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._rightpassAni = slot0._txtrightname.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0._leftunlockAni = slot0._goleft:GetComponent(typeof(UnityEngine.Animation))
	slot0._rightunlockAni = slot0._goright:GetComponent(typeof(UnityEngine.Animation))
	slot0._meshswitch1fyleft = gohelper.findChildComponent(slot0.viewGO, "#swich1/fayeleft", typeof(UIMesh))
	slot0._meshswitch1fyright = gohelper.findChildComponent(slot0.viewGO, "#swich1/fayeright", typeof(UIMesh))
	slot0._meshswitch2fyleft = gohelper.findChildComponent(slot0.viewGO, "#swich2/fayeleft", typeof(UIMesh))
	slot0._meshswitch2fyright = gohelper.findChildComponent(slot0.viewGO, "#swich2/fayeright", typeof(UIMesh))

	if not slot0._textureLoader then
		slot0._textureLoader = MultiAbLoader.New()

		slot0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))
		slot0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))
		slot0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))
		slot0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))
		slot0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))
		slot0._textureLoader:startLoad(slot0._textureBgLoaded, slot0)
	end

	slot0._topicItems = {}
	slot0._rewardIcons = {}
	slot0._rewardItems = {}
	slot0._leftDescItems = {}
	slot0._rightDescItems = {}
	slot0._showFinished = false
end

function slot0._textureBgLoaded(slot0)
	slot0._normalBgRight = slot0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))
	slot0._idlebg = slot0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))
	slot0._normalBgLeft = slot0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))
	slot0._challengeBgRight = slot0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))
	slot0._challengeBgLeft = slot0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))
end

function slot0.onUpdateParam(slot0)
end

function slot0._refreshFinishItem(slot0)
	slot0._simagefyright:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))

	slot0._meshswitch1fyright.texture = slot0._normalBgRight
	slot0._meshswitch2fyright.texture = slot0._normalBgRight

	slot0._simagefyleft:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

	slot0._meshswitch1fyleft.texture = slot0._normalBgLeft
	slot0._meshswitch2fyleft.texture = slot0._normalBgLeft

	gohelper.setActive(slot0._gorewarddetail, false)

	slot1 = TeachNoteModel.instance:isTeachNoteFinalRewardCouldGet()

	gohelper.setActive(slot0._btngetall.gameObject, slot1)
	gohelper.setActive(slot0._goreceivetip, not slot1)

	slot4 = CommonConfig.instance
	slot6 = slot4
	slot7 = ConstEnum.TeachBounds
	slot2 = string.split(slot4.getConstStr(slot6, slot7), "|")

	for slot6, slot7 in pairs(slot0._rewardIcons) do
		gohelper.setActive(slot7.go, false)
	end

	for slot6 = 1, #slot2 do
		if not slot0._rewardIcons[slot6] then
			slot8 = {
				go = gohelper.clone(slot0._gorewarddetailItem, slot0._gorewardContent, "item" .. slot6)
			}
			slot8.icon = IconMgr.instance:getCommonItemIcon(gohelper.findChild(slot8.go, "icon"))

			table.insert(slot0._rewardIcons, slot8)
		end

		gohelper.setActive(slot0._rewardIcons[slot6].go, true)

		slot8 = string.splitToNumber(slot2[slot6], "#")
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot8[1], slot8[2])

		slot0._rewardIcons[slot6].icon:setMOValue(slot8[1], slot8[2], slot8[3], nil, true)
		slot0._rewardIcons[slot6].icon:setScale(0.6)
		slot0._rewardIcons[slot6].icon:isShowQuality(false)
		slot0._rewardIcons[slot6].icon:isShowCount(false)

		gohelper.findChildText(slot0._rewardIcons[slot6].go, "name").text = slot9.name
		gohelper.findChildText(slot0._rewardIcons[slot6].go, "name/quantity").text = luaLang("multiple") .. slot8[3]
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(TeachNoteController.instance, TeachNoteEvent.ClickTopicItem, slot0._onTopicItemClicked, slot0)
	slot0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, slot0._refreshItem, slot0)
	slot0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicReward, slot0._refreshReward, slot0)
	slot0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTeachNoteFinalReward, slot0.closeThis, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0._onLoadingStartClose, slot0)

	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		slot0.viewContainer._viewSetting.anim = nil

		gohelper.setActive(slot0.viewGO, false)

		return
	end

	slot0:showViewIn()
end

function slot0.endBlock(slot0)
	UIBlockMgr.instance:endBlock("teachnote")
end

function slot0.showViewIn(slot0)
	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)

	slot0._delayTime = 1.2

	UIBlockMgr.instance:endAll()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("teachnote")
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)

	slot0._topicId, slot0._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	if slot0.viewParam.episodeId then
		slot0._showReward = false

		if #TeachNoteModel.instance:getNewOpenTopicLevels(slot0._topicId) > 0 then
			for slot7, slot8 in ipairs(TeachNoteModel.instance:getTopicLevelCos(slot0._topicId)) do
				if slot8.id == slot1[#slot1] then
					slot0._topicIndex = math.floor(0.5 * (slot7 - 1))
				end
			end

			TeachNoteModel.instance:setTeachNoticeTopicId(slot0._topicId, slot0._topicIndex)
		else
			slot0._topicIndex = 0

			for slot6, slot7 in ipairs(TeachNoteModel.instance:getTopicLevelCos(slot0._topicId)) do
				if slot7.episodeId == slot0.viewParam.episodeId then
					slot0._topicIndex = math.floor(0.5 * (slot6 - 1))
				end
			end

			TeachNoteModel.instance:setTeachNoticeTopicId(slot0._topicId, slot0._topicIndex)
		end

		if not TeachNoteModel.instance:isFinishLevelEnterFight() then
			slot3 = true

			for slot7, slot8 in ipairs(TeachNoteModel.instance:getTopicLevelCos(slot0._topicId)) do
				if not DungeonModel.instance:hasPassLevel(slot8.episodeId) then
					slot3 = false
				end
			end

			if slot3 then
				slot0._showReward = true

				TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)
			end
		end

		if slot0._topicId == 0 then
			TeachNoteModel.instance:setTeachNoticeTopicId(1, 0)
		end
	else
		slot0._showReward = true

		TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)
	end

	slot0:_refreshItem()
end

function slot0.onOpenFinish(slot0)
	HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.TeachNote)
end

function slot0._onLoadingStartClose(slot0)
	gohelper.setActive(slot0.viewGO, false)
	TaskDispatcher.runDelay(slot0._playBackTeachNote, slot0, 0.6)
end

function slot0._playBackTeachNote(slot0)
	gohelper.setActive(slot0.viewGO, true)
	slot0:showViewIn()

	slot0._viewAnim.enabled = true
	slot0.viewContainer._viewSetting.anim = ViewAnim.Internal

	slot0._viewAnim:Play(UIAnimationName.Open, 0, 0)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if slot0._showReward then
		return
	end

	slot0._startPos = slot2.position.x
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if slot0._showReward then
		return
	end

	if slot0._startPos < slot2.position.x and slot3 - slot0._startPos >= 100 then
		slot0:_changeRight()
	elseif slot3 < slot0._startPos and slot0._startPos - slot3 >= 100 then
		slot0:_changeLeft()
	end
end

function slot0.onClose(slot0)
	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play(UIAnimationName.Close, 0, 0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.ClickTopicItem, slot0._onTopicItemClicked, slot0)
	slot0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, slot0._refreshItem, slot0)
	slot0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicReward, slot0._refreshReward, slot0)
	slot0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTeachNoteFinalReward, slot0.closeThis, slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0._onLoadingStartClose, slot0)
end

function slot0._onTopicItemClicked(slot0, slot1)
	slot0.viewParam.episodeId = nil

	TeachNoteModel.instance:setLevelEnterFightState(false)

	slot0._showReward = false
	slot0._delayTime = 0
	slot0._topicId = slot1
	slot2 = TeachNoteModel.instance:getTopicLevelCos(slot0._topicId)
	slot3 = math.floor(0.5 * (#slot2 - 1))

	for slot7 = #slot2, 1, -1 do
		if not TeachNoteModel.instance:isTeachNoteLevelPass(slot2[slot7].id) then
			slot3 = math.floor(0.5 * (slot7 - 1))
		end
	end

	TeachNoteModel.instance:setTeachNoticeTopicId(slot0._topicId, slot3)
	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	if slot0._showReward then
		slot0:_refreshReward()
	else
		slot0:_refreshLevel()
	end

	slot0:_refreshTopic()
end

function slot0._refreshTopicFinishState(slot0, slot1)
	return TeachNoteModel.instance:getTeachNoteTopicLevelCount(slot1) == TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(slot1)
end

function slot0._refreshTopic(slot0)
	if slot0._topicItems then
		for slot4, slot5 in pairs(slot0._topicItems) do
			slot5:onDestroyView()
		end
	end

	slot0._topicItems = {}

	for slot5 = 1, #TeachNoteConfig.instance:getInstructionTopicCos() do
		slot6 = gohelper.cloneInPlace(slot0._gotopicitem)

		gohelper.setActive(slot6, true)

		slot7 = TeachNoteTopicListItem.New()

		slot7:init(slot6, slot1[slot5].id, slot5, slot0._showReward, slot0:_refreshTopicFinishState(slot1[slot5].id))
		table.insert(slot0._topicItems, slot7)
	end

	gohelper.setActive(slot0._gorewardredpoint, TeachNoteModel.instance:hasRewardCouldGet())
end

function slot0._onPlayLeftFinishedIn(slot0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_finish)
	slot0._leftpassAni:Play("in", 0, 0)
end

function slot0._onPlayRightFinishedIn(slot0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_finish)
	slot0._rightpassAni:Play("in", 0, 0)
end

function slot0._refreshLevel(slot0)
	gohelper.setActive(slot0._golevel, true)
	gohelper.setActive(slot0._goreward, false)
	gohelper.setActive(slot0._gorewardBeSelected, false)
	gohelper.setActive(slot0._gorewardUnselected, true)

	slot0._topicId, slot0._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	gohelper.setActive(slot0._btnleftarrow.gameObject, #TeachNoteModel.instance:getTopicLevelCos(slot0._topicId) > 2 and slot0._tag >= math.ceil(0.5 * #slot1) - 1 or false)
	gohelper.setActive(slot0._btnrightarrow.gameObject, #slot1 > 2 and slot0._tag <= 0 or false)

	slot4 = {
		"bg_jiaoxuebiji_anniudi",
		"bg_jiaoxuebiji_anniudi_1"
	}
	slot5 = {
		"#F7F7F7",
		"#45413E"
	}
	slot7 = slot1[2 * slot0._tag + 1]

	if slot1[2 * slot0._tag + 2] then
		gohelper.setActive(slot0._goright, true)
		gohelper.setActive(slot0._goend, false)
		slot0._simagerighticon:LoadImage(ResUrl.getTeachNoteImage(TeachNoteModel.instance:isLevelUnlock(slot6.id) and slot6.picRes .. ".png" or "bg_jiaoxuebiji_kongdi.png"))

		slot10 = DungeonConfig.instance:getEpisodeCO(slot6.episodeId).chapterId == 1107

		slot0._simagefyright:LoadImage(ResUrl.getTeachNoteImage(slot10 and "bg_jiaoxuebiji_bijiben_3.png" or "bg_jiaoxuebiji_bijiben_2.png"))

		slot12 = slot10 and slot0._challengeBgRight or slot0._idlebg
		slot0._meshswitch1fyright.texture = slot12
		slot0._meshswitch2fyright.texture = slot12

		gohelper.setActive(slot0._gorightunlock, slot8)
		gohelper.setActive(slot0._gorightlock, not slot8)
		gohelper.setActive(slot0._gorightnotetip, slot8)
		UISpriteSetMgr.instance:setTeachNoteSprite(slot0._imagerightindex, "bg_jiaoxuebiji_shuzi_" .. 2 * slot0._tag + 2)

		slot15 = DungeonConfig.instance:getEpisodeCO(TeachNoteConfig.instance:getInstructionLevelCO(slot6.id).episodeId)
		slot0._txtrightname.text = slot15.name
		slot0._txtrightnameen.text = slot15.name_En
		slot0._txtrightnotedesc.text = slot6.instructionDesc

		if TeachNoteModel.instance:isTeachNoteLevelPass(slot6.id) then
			slot0._rightpassAni.enabled = true

			if slot0:_isLevelNewFinished(slot6.id) then
				slot0._rightunlockAni.enabled = false

				TaskDispatcher.cancelTask(slot0._onPlayRightFinishedIn, slot0)
				TaskDispatcher.runDelay(slot0._onPlayRightFinishedIn, slot0, 0.5)
			else
				slot0._rightpassAni:Play("done", 0, 0)
			end

			slot18 = {}

			if slot14 > 0 and not TeachNoteModel.instance:isEpisodeOpen(slot14) then
				table.insert(slot18, slot14)
			end

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(slot18)

			slot0._txtrightstartcn.text = luaLang("teachnoteview_restart")
		else
			slot0._rightpassAni.enabled = false

			gohelper.setActive(slot0._gorightpass, false)
			gohelper.setActive(slot0._gorightpassdone, false)

			slot0._rightlockCanvas.alpha = 1
			slot0._txtrightstartcn.text = luaLang("teachnoteview_start")
		end

		if TeachNoteModel.instance:isLevelNewUnlock(slot6.id) and not slot16 and not slot17 then
			AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_unlock)

			slot19 = {}

			if slot14 > 0 and not TeachNoteModel.instance:isEpisodeOpen(slot14) then
				table.insert(slot19, slot14)
			end

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(slot19)

			slot0._delayTime = slot0._delayTime + 1
			slot0._leftunlockAni.enabled = false
			slot0._rightunlockAni.enabled = true

			slot0._rightunlockAni:Play()
		end

		UISpriteSetMgr.instance:setTeachNoteSprite(slot0._imagerightlearn, slot17 and slot4[2] or slot4[1])
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrightstartcn, slot17 and slot5[2] or slot5[1])
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtrightstarten, slot17 and slot5[2] or slot5[1])
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtrightstarten, 0.5)

		if slot0._rightDescItems then
			for slot23, slot24 in pairs(slot0._rightDescItems) do
				slot24:onDestroyView()
			end
		end

		slot0._rightDescItems = {}
		slot25 = slot6.id
		slot21 = nil

		for slot25 = 1, #string.split(TeachNoteConfig.instance:getInstructionLevelCO(slot25).desc, "#") do
			slot26 = gohelper.cloneInPlace(slot0._gorightdescitem)

			gohelper.setActive(slot26, true)

			slot21 = TeachNoteDescItem.New()

			slot21:init(slot26, slot25, slot6.id)
			table.insert(slot0._rightDescItems, slot21)
		end
	else
		slot8 = DungeonConfig.instance:getEpisodeCO(slot7.episodeId).chapterId == 1107

		slot0._simagefyright:LoadImage(ResUrl.getTeachNoteImage(slot8 and "bg_jiaoxuebiji_bijiben_3.png" or "bg_jiaoxuebiji_bijiben_2.png"))

		slot10 = slot8 and slot0._challengeBgRight or slot0._idlebg
		slot0._meshswitch1fyright.texture = slot10
		slot0._meshswitch2fyright.texture = slot10

		gohelper.setActive(slot0._goright, false)
		gohelper.setActive(slot0._goend, true)
	end

	if slot7 then
		gohelper.setActive(slot0._goleft, true)
		slot0._simagelefticon:LoadImage(ResUrl.getTeachNoteImage(TeachNoteModel.instance:isLevelUnlock(slot7.id) and slot7.picRes .. ".png" or "bg_jiaoxuebiji_kongdi.png"))

		slot10 = DungeonConfig.instance:getEpisodeCO(slot7.episodeId).chapterId == 1107

		slot0._simagefyleft:LoadImage(ResUrl.getTeachNoteImage(slot10 and "bg_jiaoxuebiji_bijiben_4.png" or "bg_jiaoxuebiji_bijiben_2_1.png"))

		slot12 = slot10 and slot0._challengeBgLeft or slot0._normalBgLeft
		slot0._meshswitch1fyleft.texture = slot12
		slot0._meshswitch2fyleft.texture = slot12

		gohelper.setActive(slot0._goleftunlock, slot8)
		gohelper.setActive(slot0._goleftlock, not slot8)
		gohelper.setActive(slot0._goleftnotetip, slot8)
		UISpriteSetMgr.instance:setTeachNoteSprite(slot0._imageleftindex, "bg_jiaoxuebiji_shuzi_" .. 2 * slot0._tag + 1)

		slot15 = DungeonConfig.instance:getEpisodeCO(TeachNoteConfig.instance:getInstructionLevelCO(slot7.id).episodeId)
		slot0._txtleftname.text = slot15.name
		slot0._txtleftnameen.text = slot15.name_En
		slot0._txtleftnotedesc.text = slot7.instructionDesc

		if TeachNoteModel.instance:isTeachNoteLevelPass(slot7.id) then
			slot0._leftpassAni.enabled = true

			if slot0:_isLevelNewFinished(slot7.id) then
				TaskDispatcher.cancelTask(slot0._onPlayLeftFinishedIn, slot0)
				TaskDispatcher.runDelay(slot0._onPlayLeftFinishedIn, slot0, 0.5)
			else
				slot0._leftpassAni:Play("done", 0, 0)
			end

			slot18 = {}

			if slot14 > 0 and not TeachNoteModel.instance:isEpisodeOpen(slot14) then
				table.insert(slot18, slot14)
			end

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(slot18)

			slot0._txtleftstartcn.text = luaLang("teachnoteview_restart")
		else
			slot0._leftpassAni.enabled = false

			gohelper.setActive(slot0._goleftpass, false)
			gohelper.setActive(slot0._goleftpassdone, false)

			slot0._leftlockCanvas.alpha = 1
			slot0._txtleftstartcn.text = luaLang("teachnoteview_start")
		end

		if TeachNoteModel.instance:isLevelNewUnlock(slot7.id) and not slot16 and not slot0._rightunlockAni.isPlaying and not slot17 then
			AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_unlock)

			slot19 = {}

			if slot14 > 0 and not TeachNoteModel.instance:isEpisodeOpen(slot14) then
				table.insert(slot19, slot14)
			end

			slot0._delayTime = slot0._delayTime + 1

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(slot19)

			slot0._leftunlockAni.enabled = true
			slot0._rightunlockAni.enabled = false

			slot0._leftunlockAni:Play()
		end

		UISpriteSetMgr.instance:setTeachNoteSprite(slot0._imageleftlearn, slot17 and slot4[2] or slot4[1])
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtleftstartcn, slot17 and slot5[2] or slot5[1])
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtleftstarten, slot17 and slot5[2] or slot5[1])
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtleftstarten, 0.5)

		if slot0._leftDescItems then
			for slot23, slot24 in pairs(slot0._leftDescItems) do
				slot24:onDestroyView()
			end
		end

		slot0._leftDescItems = {}
		slot20 = nil
		slot23 = TeachNoteConfig.instance
		slot25 = slot23

		for slot25 = 1, #string.split(slot23.getInstructionLevelCO(slot25, slot7.id).desc, "#") do
			slot26 = gohelper.cloneInPlace(slot0._goleftdescitem)

			gohelper.setActive(slot26, true)

			slot20 = TeachNoteDescItem.New()

			slot20:init(slot26, slot25, slot7.id)
			table.insert(slot0._leftDescItems, slot20)
		end
	else
		slot0._simagefyleft:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

		slot0._meshswitch1fyleft.texture = slot0._normalBgLeft
		slot0._meshswitch2fyleft.texture = slot0._normalBgLeft

		gohelper.setActive(slot0._goleft, false)
	end

	TaskDispatcher.cancelTask(slot0.endBlock, slot0)
	TaskDispatcher.runDelay(slot0.endBlock, slot0, slot0._delayTime)
end

function slot0._setLearnBtnColor(slot0, slot1, slot2)
	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot2 and "#45413E" or "#F7F7F7")
end

function slot0._isLevelNewFinished(slot0, slot1)
	if TeachNoteModel.instance:isFinishLevelEnterFight() then
		return false
	end

	if not slot0.viewParam.episodeId then
		return false
	end

	if slot0.viewParam.episodeId == TeachNoteConfig.instance:getInstructionLevelCO(slot1).episodeId and not TeachNoteModel.instance:isTeachNoteLevelPass(slot1) and not slot0._showFinished then
		slot0._showFinished = true

		return true
	end

	return false
end

function slot0._refreshReward(slot0)
	slot0:endBlock()
	gohelper.setActive(slot0._golevel, false)
	gohelper.setActive(slot0._goreward, true)
	gohelper.setActive(slot0._gorewardBeSelected, true)
	gohelper.setActive(slot0._gorewardUnselected, false)
	TeachNoteRewardListModel.instance:setRewardList(TeachNoteConfig.instance:getInstructionTopicCos())
	slot0:_refreshFinishItem()
end

function slot0._changeLeft(slot0)
	slot0._topicId, slot0._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	if slot0._tag >= math.ceil(0.5 * #TeachNoteModel.instance:getTopicLevelCos(slot0._topicId)) - 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("fanye02", 0, 0)

	slot0._tag = slot0._tag + 1

	TeachNoteModel.instance:setTeachNoticeTopicId(slot0._topicId, slot0._tag)
	TaskDispatcher.cancelTask(slot0._refreshLevel, slot0)
	TaskDispatcher.runDelay(slot0._refreshLevel, slot0, 0.3)
end

function slot0._changeRight(slot0)
	if slot0._tag < 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	slot0._viewAnim.enabled = true

	slot0._viewAnim:Play("fanye01", 0, 0)

	slot0._tag = slot0._tag - 1

	TeachNoteModel.instance:setTeachNoticeTopicId(slot0._topicId, slot0._tag)
	TaskDispatcher.cancelTask(slot0._refreshLevel, slot0)
	TaskDispatcher.runDelay(slot0._refreshLevel, slot0, 0.3)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onPlayLeftFinishedIn, slot0)
	TaskDispatcher.cancelTask(slot0._onPlayRightFinishedIn, slot0)
	TaskDispatcher.cancelTask(slot0._refreshLevel, slot0)
	TaskDispatcher.cancelTask(slot0.endBlock, slot0)
	TaskDispatcher.cancelTask(slot0._playBackTeachNote, slot0)

	if slot0._textureLoader then
		slot0._textureLoader:dispose()

		slot0._textureLoader = nil
	end

	slot0._simagebg:UnLoadImage()
	slot0._simagefyright:UnLoadImage()
	slot0._simagefyleft:UnLoadImage()
	slot0._simagelefticon:UnLoadImage()
	slot0._simagerighticon:UnLoadImage()
	slot0._simagerewardbg1:UnLoadImage()
	slot0._simagelefunlock:UnLoadImage()
	slot0._simagerightunlock:UnLoadImage()
	slot0._simageleftlockmask:UnLoadImage()
	slot0._simagerightlockmask:UnLoadImage()

	if slot0._topicItems then
		for slot4, slot5 in pairs(slot0._topicItems) do
			slot5:onDestroyView()
		end

		slot0._topicItems = nil
	end

	if slot0._leftDescItems then
		for slot4, slot5 in pairs(slot0._leftDescItems) do
			slot5:onDestroyView()
		end

		slot0._leftDescItems = nil
	end

	if slot0._rightDescItems then
		for slot4, slot5 in pairs(slot0._rightDescItems) do
			slot5:onDestroyView()
		end

		slot0._rightDescItems = nil
	end

	if slot0._rewardIcons then
		for slot4, slot5 in pairs(slot0._rewardIcons) do
			gohelper.destroy(slot5.go)
			slot5.icon:onDestroy()
		end

		slot0._rewardIcons = nil
	end
end

return slot0
