module("modules.logic.teach.view.TeachNoteView", package.seeall)

local var_0_0 = class("TeachNoteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagefyleft = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fy/#simage_fyleft")
	arg_1_0._simagefyright = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fy/#simage_fyright")
	arg_1_0._gotopic = gohelper.findChild(arg_1_0.viewGO, "#go_topic")
	arg_1_0._gotopicitem = gohelper.findChild(arg_1_0.viewGO, "#go_topic/#go_topicitem")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_reward")
	arg_1_0._scrollrewarditem = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_reward/#scroll_rewarditem")
	arg_1_0._gofinish = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_finish")
	arg_1_0._simagerewardbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_reward/#go_finish/#simage_rewardbg1")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_reward/#go_finish/#btn_getall")
	arg_1_0._gorewarddetail = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail")
	arg_1_0._btnrewarddetailclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#btn_rewarddetailclose")
	arg_1_0._gocontentSize = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_contentSize")
	arg_1_0._goitems = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_items")
	arg_1_0._gorewarddetailItem = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_items/#go_rewarddetailItem")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_items/Viewport/Content/#go_rewardContent")
	arg_1_0._goclickarea = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_items/Viewport/Content/#go_rewardContent/#go_clickarea")
	arg_1_0._goitemex = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_itemex")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewarddetail/#go_itemex/#go_item")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._gorewardredpoint = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_rewardredpoint")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "#go_level")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left")
	arg_1_0._simagelefunlock = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#go_left/#simage_unlock")
	arg_1_0._simagelefticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#go_left/#simage_lefticon")
	arg_1_0._txtleftname = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_left/#txt_leftname")
	arg_1_0._goleftpass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left/#txt_leftname/#go_leftpass")
	arg_1_0._goleftpassdone = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left/#txt_leftname/#go_leftpassdone")
	arg_1_0._txtleftnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_left/#txt_leftnameen")
	arg_1_0._imageleftindex = gohelper.findChildImage(arg_1_0.viewGO, "#go_level/#go_left/#image_leftindex")
	arg_1_0._goleftnotetip = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left/#go_leftnotetip")
	arg_1_0._txtleftnotedesc = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_left/#go_leftnotetip/#txt_leftnotedesc")
	arg_1_0._goleftdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left/leftitemdescs/#go_leftdescitem")
	arg_1_0._goleftunlock = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left/#go_leftunlock")
	arg_1_0._btnleftlearn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn")
	arg_1_0._goleftlock = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_left/#go_leftlock")
	arg_1_0._btnleftarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_level/#go_left/#btn_leftarrow")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right")
	arg_1_0._simagerightunlock = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#go_right/#simage_unlock")
	arg_1_0._simagerighticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#go_right/#simage_righticon")
	arg_1_0._txtrightname = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_right/#txt_rightname")
	arg_1_0._gorightpass = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right/#txt_rightname/#go_leftpass")
	arg_1_0._gorightpassdone = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right/#txt_rightname/#go_leftpassdone")
	arg_1_0._txtrightnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_right/#txt_rightnameen")
	arg_1_0._imagerightindex = gohelper.findChildImage(arg_1_0.viewGO, "#go_level/#go_right/#image_rightindex")
	arg_1_0._gorightnotetip = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right/#go_rightnotetip")
	arg_1_0._txtrightnotedesc = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_right/#go_rightnotetip/#txt_rightnotedesc")
	arg_1_0._gorightdescitem = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right/rightitemdescs/#go_rightdescitem")
	arg_1_0._gorightunlock = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right/#go_rightunlock")
	arg_1_0._btnrightlearn = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn")
	arg_1_0._gorightlock = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_right/#go_rightlock")
	arg_1_0._btnrightarrow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_level/#go_right/#btn_rightarrow")
	arg_1_0._goend = gohelper.findChild(arg_1_0.viewGO, "#go_level/#go_end")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._txtleftstartcn = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn/#txt_leftstartcn")
	arg_1_0._txtleftstarten = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn/#txt_leftstarten")
	arg_1_0._txtrightstartcn = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn/#txt_rightstartcn")
	arg_1_0._txtrightstarten = gohelper.findChildText(arg_1_0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn/#txt_rightstarten")
	arg_1_0._simageleftlockmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#go_left/#go_leftlock/#simage_leftlockmask")
	arg_1_0._simagerightlockmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_level/#go_right/#go_rightlock/#simage_rightlockmask")
	arg_1_0._goreceivetip = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_finish/#go_receivetip")
	arg_1_0._btnreward1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_reward/#go_finish/#go_reward1/click")
	arg_1_0._btnreward2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_reward/#go_finish/#go_reward2/click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._btngetallOnClick, arg_2_0)
	arg_2_0._btnrewarddetailclose:AddClickListener(arg_2_0._btnrewarddetailcloseOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnleftlearn:AddClickListener(arg_2_0._btnleftlearnOnClick, arg_2_0)
	arg_2_0._btnleftarrow:AddClickListener(arg_2_0._btnleftarrowOnClick, arg_2_0)
	arg_2_0._btnrightlearn:AddClickListener(arg_2_0._btnrightlearnOnClick, arg_2_0)
	arg_2_0._btnrightarrow:AddClickListener(arg_2_0._btnrightarrowOnClick, arg_2_0)
	arg_2_0._btnreward1:AddClickListener(arg_2_0._btnreward1OnClick, arg_2_0)
	arg_2_0._btnreward2:AddClickListener(arg_2_0._btnreward2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngetall:RemoveClickListener()
	arg_3_0._btnrewarddetailclose:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnleftlearn:RemoveClickListener()
	arg_3_0._btnleftarrow:RemoveClickListener()
	arg_3_0._btnrightlearn:RemoveClickListener()
	arg_3_0._btnrightarrow:RemoveClickListener()
	arg_3_0._btnreward1:RemoveClickListener()
	arg_3_0._btnreward2:RemoveClickListener()
end

function var_0_0._btnleftarrowOnClick(arg_4_0)
	arg_4_0:_changeRight()
end

function var_0_0._btnrightarrowOnClick(arg_5_0)
	arg_5_0:_changeLeft()
end

function var_0_0._btnreward1OnClick(arg_6_0)
	MaterialTipController.instance:showMaterialInfo(7, 2)
end

function var_0_0._btnreward2OnClick(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(1, 133023)
end

function var_0_0._btngetallOnClick(arg_8_0)
	if not TeachNoteModel.instance:isTeachNoteFinalRewardCouldGet() then
		gohelper.setActive(arg_8_0._gorewarddetail, true)
	else
		DungeonRpc.instance:sendInstructionDungeonFinalRewardRequest()
	end
end

function var_0_0._btnrewarddetailcloseOnClick(arg_9_0)
	gohelper.setActive(arg_9_0._gorewarddetail, false)
end

function var_0_0._btnrightlearnOnClick(arg_10_0)
	local var_10_0 = TeachNoteModel.instance:getTeachNoticeTopicId()
	local var_10_1 = TeachNoteModel.instance:getTopicLevelCos(var_10_0)[2 * arg_10_0._tag + 2]

	if arg_10_0.viewParam.isJump then
		TeachNoteModel.instance:setJumpEpisodeId(var_10_1.episodeId)

		local var_10_2 = DungeonConfig.instance:getEpisodeCO(var_10_1.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(var_10_2, var_10_1.episodeId)
	else
		DungeonModel.instance.curLookEpisodeId = var_10_1.episodeId

		local var_10_3 = TeachNoteModel.instance:isTeachNoteLevelPass(var_10_1.id)

		TeachNoteModel.instance:setLevelEnterFightState(var_10_3)

		local var_10_4 = DungeonConfig.instance:getEpisodeCO(var_10_1.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(var_10_4, var_10_1.episodeId)
	end
end

function var_0_0._btnleftlearnOnClick(arg_11_0)
	local var_11_0 = TeachNoteModel.instance:getTeachNoticeTopicId()
	local var_11_1 = TeachNoteModel.instance:getTopicLevelCos(var_11_0)[2 * arg_11_0._tag + 1]

	if arg_11_0.viewParam.isJump then
		TeachNoteModel.instance:setJumpEpisodeId(var_11_1.episodeId)

		local var_11_2 = DungeonConfig.instance:getEpisodeCO(var_11_1.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(var_11_2, var_11_1.episodeId)
	else
		DungeonModel.instance.curLookEpisodeId = var_11_1.episodeId

		local var_11_3 = TeachNoteModel.instance:isTeachNoteLevelPass(var_11_1.id)

		TeachNoteModel.instance:setLevelEnterFightState(var_11_3)

		local var_11_4 = DungeonConfig.instance:getEpisodeCO(var_11_1.episodeId).chapterId

		TeachNoteModel.instance:setTeachNoteEnterFight(true, false)
		DungeonFightController.instance:enterFight(var_11_4, var_11_1.episodeId)
	end
end

function var_0_0._btnrewardOnClick(arg_12_0)
	if arg_12_0._showReward then
		return
	end

	TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)

	arg_12_0._showReward = true

	arg_12_0:_refreshItem()
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_13_0._simagebg.gameObject)
	arg_13_0._gorewardBeSelected = gohelper.findChild(arg_13_0.viewGO, "#btn_reward/beselected")
	arg_13_0._gorewardUnselected = gohelper.findChild(arg_13_0.viewGO, "#btn_reward/unselected")
	arg_13_0._imageleftlearn = gohelper.findChildImage(arg_13_0.viewGO, "#go_level/#go_left/#go_leftunlock/#btn_leftlearn")
	arg_13_0._imagerightlearn = gohelper.findChildImage(arg_13_0.viewGO, "#go_level/#go_right/#go_rightunlock/#btn_rightlearn")
	arg_13_0._leftlockCanvas = arg_13_0._goleftlock:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_13_0._rightlockCanvas = arg_13_0._gorightlock:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(arg_13_0._btnreward.gameObject, AudioEnum.TeachNote.play_ui_activity_switch)
	gohelper.addUIClickAudio(arg_13_0._btngetall.gameObject, AudioEnum.TeachNote.play_ui_activity_act)
	gohelper.addUIClickAudio(arg_13_0._btnleftlearn.gameObject, AudioEnum.TeachNote.play_ui_activity_jump)
	gohelper.addUIClickAudio(arg_13_0._btnrightlearn.gameObject, AudioEnum.TeachNote.play_ui_activity_jump)
	gohelper.removeUIClickAudio(arg_13_0._btnleftarrow.gameObject)
	gohelper.removeUIClickAudio(arg_13_0._btnrightarrow.gameObject)
	arg_13_0._simagebg:LoadImage(ResUrl.getTeachNoteImage("full/bg_jiaoxuebiji_beijingtu.jpg"))
	arg_13_0._simagerewardbg1:LoadImage(ResUrl.getTeachNoteImage("bg_jianglixuanchuan.png"))
	arg_13_0._simagelefunlock:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_kongdi.png"))
	arg_13_0._simagerightunlock:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_kongdi.png"))
	arg_13_0._simageleftlockmask:LoadImage(ResUrl.getTeachNoteImage("btn_zhezhao_1.png"))
	arg_13_0._simagerightlockmask:LoadImage(ResUrl.getTeachNoteImage("btn_zhezhao.png"))

	arg_13_0._viewAnim = arg_13_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._leftpassAni = arg_13_0._txtleftname.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._rightpassAni = arg_13_0._txtrightname.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._leftunlockAni = arg_13_0._goleft:GetComponent(typeof(UnityEngine.Animation))
	arg_13_0._rightunlockAni = arg_13_0._goright:GetComponent(typeof(UnityEngine.Animation))
	arg_13_0._meshswitch1fyleft = gohelper.findChildComponent(arg_13_0.viewGO, "#swich1/fayeleft", typeof(UIMesh))
	arg_13_0._meshswitch1fyright = gohelper.findChildComponent(arg_13_0.viewGO, "#swich1/fayeright", typeof(UIMesh))
	arg_13_0._meshswitch2fyleft = gohelper.findChildComponent(arg_13_0.viewGO, "#swich2/fayeleft", typeof(UIMesh))
	arg_13_0._meshswitch2fyright = gohelper.findChildComponent(arg_13_0.viewGO, "#swich2/fayeright", typeof(UIMesh))

	if not arg_13_0._textureLoader then
		arg_13_0._textureLoader = MultiAbLoader.New()

		arg_13_0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))
		arg_13_0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))
		arg_13_0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))
		arg_13_0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))
		arg_13_0._textureLoader:addPath(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))
		arg_13_0._textureLoader:startLoad(arg_13_0._textureBgLoaded, arg_13_0)
	end

	arg_13_0._topicItems = {}
	arg_13_0._rewardIcons = {}
	arg_13_0._rewardItems = {}
	arg_13_0._leftDescItems = {}
	arg_13_0._rightDescItems = {}
	arg_13_0._showFinished = false
end

function var_0_0._textureBgLoaded(arg_14_0)
	arg_14_0._normalBgRight = arg_14_0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))
	arg_14_0._idlebg = arg_14_0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2.png"))
	arg_14_0._normalBgLeft = arg_14_0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))
	arg_14_0._challengeBgRight = arg_14_0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_3.png"))
	arg_14_0._challengeBgLeft = arg_14_0._textureLoader:getAssetItem(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png")):GetResource(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_4.png"))
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0._refreshFinishItem(arg_16_0)
	arg_16_0._simagefyright:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_6.png"))

	arg_16_0._meshswitch1fyright.texture = arg_16_0._normalBgRight
	arg_16_0._meshswitch2fyright.texture = arg_16_0._normalBgRight

	arg_16_0._simagefyleft:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

	arg_16_0._meshswitch1fyleft.texture = arg_16_0._normalBgLeft
	arg_16_0._meshswitch2fyleft.texture = arg_16_0._normalBgLeft

	gohelper.setActive(arg_16_0._gorewarddetail, false)

	local var_16_0 = TeachNoteModel.instance:isTeachNoteFinalRewardCouldGet()

	gohelper.setActive(arg_16_0._btngetall.gameObject, var_16_0)
	gohelper.setActive(arg_16_0._goreceivetip, not var_16_0)

	local var_16_1 = string.split(CommonConfig.instance:getConstStr(ConstEnum.TeachBounds), "|")

	for iter_16_0, iter_16_1 in pairs(arg_16_0._rewardIcons) do
		gohelper.setActive(iter_16_1.go, false)
	end

	for iter_16_2 = 1, #var_16_1 do
		if not arg_16_0._rewardIcons[iter_16_2] then
			local var_16_2 = {
				go = gohelper.clone(arg_16_0._gorewarddetailItem, arg_16_0._gorewardContent, "item" .. iter_16_2)
			}
			local var_16_3 = gohelper.findChild(var_16_2.go, "icon")

			var_16_2.icon = IconMgr.instance:getCommonItemIcon(var_16_3)

			table.insert(arg_16_0._rewardIcons, var_16_2)
		end

		gohelper.setActive(arg_16_0._rewardIcons[iter_16_2].go, true)

		local var_16_4 = string.splitToNumber(var_16_1[iter_16_2], "#")
		local var_16_5, var_16_6 = ItemModel.instance:getItemConfigAndIcon(var_16_4[1], var_16_4[2])

		arg_16_0._rewardIcons[iter_16_2].icon:setMOValue(var_16_4[1], var_16_4[2], var_16_4[3], nil, true)
		arg_16_0._rewardIcons[iter_16_2].icon:setScale(0.6)
		arg_16_0._rewardIcons[iter_16_2].icon:isShowQuality(false)
		arg_16_0._rewardIcons[iter_16_2].icon:isShowCount(false)

		gohelper.findChildText(arg_16_0._rewardIcons[iter_16_2].go, "name").text = var_16_5.name
		gohelper.findChildText(arg_16_0._rewardIcons[iter_16_2].go, "name/quantity").text = luaLang("multiple") .. var_16_4[3]
	end
end

function var_0_0.onOpen(arg_17_0)
	arg_17_0:addEventCb(TeachNoteController.instance, TeachNoteEvent.ClickTopicItem, arg_17_0._onTopicItemClicked, arg_17_0)
	arg_17_0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, arg_17_0._refreshItem, arg_17_0)
	arg_17_0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicReward, arg_17_0._refreshReward, arg_17_0)
	arg_17_0:addEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTeachNoteFinalReward, arg_17_0.closeThis, arg_17_0)
	arg_17_0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_17_0._onLoadingStartClose, arg_17_0)

	if ViewMgr.instance:isOpen(ViewName.LoadingView) then
		arg_17_0.viewContainer._viewSetting.anim = nil

		gohelper.setActive(arg_17_0.viewGO, false)

		return
	end

	arg_17_0:showViewIn()
end

function var_0_0.endBlock(arg_18_0)
	UIBlockMgr.instance:endBlock("teachnote")
end

function var_0_0.showViewIn(arg_19_0)
	arg_19_0._drag:AddDragBeginListener(arg_19_0._onDragBegin, arg_19_0)
	arg_19_0._drag:AddDragEndListener(arg_19_0._onDragEnd, arg_19_0)

	arg_19_0._delayTime = 1.2

	UIBlockMgr.instance:endAll()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("teachnote")
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)

	arg_19_0._topicId, arg_19_0._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	if arg_19_0.viewParam.episodeId then
		arg_19_0._showReward = false

		local var_19_0 = TeachNoteModel.instance:getNewOpenTopicLevels(arg_19_0._topicId)

		if #var_19_0 > 0 then
			local var_19_1 = var_19_0[#var_19_0]
			local var_19_2 = TeachNoteModel.instance:getTopicLevelCos(arg_19_0._topicId)

			for iter_19_0, iter_19_1 in ipairs(var_19_2) do
				if iter_19_1.id == var_19_1 then
					arg_19_0._topicIndex = math.floor(0.5 * (iter_19_0 - 1))
				end
			end

			TeachNoteModel.instance:setTeachNoticeTopicId(arg_19_0._topicId, arg_19_0._topicIndex)
		else
			local var_19_3 = TeachNoteModel.instance:getTopicLevelCos(arg_19_0._topicId)

			arg_19_0._topicIndex = 0

			for iter_19_2, iter_19_3 in ipairs(var_19_3) do
				if iter_19_3.episodeId == arg_19_0.viewParam.episodeId then
					arg_19_0._topicIndex = math.floor(0.5 * (iter_19_2 - 1))
				end
			end

			TeachNoteModel.instance:setTeachNoticeTopicId(arg_19_0._topicId, arg_19_0._topicIndex)
		end

		if not TeachNoteModel.instance:isFinishLevelEnterFight() then
			local var_19_4 = TeachNoteModel.instance:getTopicLevelCos(arg_19_0._topicId)
			local var_19_5 = true

			for iter_19_4, iter_19_5 in ipairs(var_19_4) do
				if not DungeonModel.instance:hasPassLevel(iter_19_5.episodeId) then
					var_19_5 = false
				end
			end

			if var_19_5 then
				arg_19_0._showReward = true

				TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)
			end
		end

		if arg_19_0._topicId == 0 then
			TeachNoteModel.instance:setTeachNoticeTopicId(1, 0)
		end
	else
		arg_19_0._showReward = true

		TeachNoteModel.instance:setTeachNoticeTopicId(0, 0)
	end

	arg_19_0:_refreshItem()
end

function var_0_0.onOpenFinish(arg_20_0)
	HelpController.instance:tryShowFirstHelp(HelpEnum.HelpId.TeachNote)
end

function var_0_0._onLoadingStartClose(arg_21_0)
	gohelper.setActive(arg_21_0.viewGO, false)
	TaskDispatcher.runDelay(arg_21_0._playBackTeachNote, arg_21_0, 0.6)
end

function var_0_0._playBackTeachNote(arg_22_0)
	gohelper.setActive(arg_22_0.viewGO, true)
	arg_22_0:showViewIn()

	arg_22_0._viewAnim.enabled = true
	arg_22_0.viewContainer._viewSetting.anim = ViewAnim.Internal

	arg_22_0._viewAnim:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0._onDragBegin(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0._showReward then
		return
	end

	arg_23_0._startPos = arg_23_2.position.x
end

function var_0_0._onDragEnd(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._showReward then
		return
	end

	local var_24_0 = arg_24_2.position.x

	if var_24_0 > arg_24_0._startPos and var_24_0 - arg_24_0._startPos >= 100 then
		arg_24_0:_changeRight()
	elseif var_24_0 < arg_24_0._startPos and arg_24_0._startPos - var_24_0 >= 100 then
		arg_24_0:_changeLeft()
	end
end

function var_0_0.onClose(arg_25_0)
	arg_25_0._viewAnim.enabled = true

	arg_25_0._viewAnim:Play(UIAnimationName.Close, 0, 0)
	arg_25_0._drag:RemoveDragBeginListener()
	arg_25_0._drag:RemoveDragEndListener()
	arg_25_0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.ClickTopicItem, arg_25_0._onTopicItemClicked, arg_25_0)
	arg_25_0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicInfo, arg_25_0._refreshItem, arg_25_0)
	arg_25_0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTopicReward, arg_25_0._refreshReward, arg_25_0)
	arg_25_0:removeEventCb(TeachNoteController.instance, TeachNoteEvent.GetServerTeachNoteFinalReward, arg_25_0.closeThis, arg_25_0)
	arg_25_0:removeEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_25_0._onLoadingStartClose, arg_25_0)
end

function var_0_0._onTopicItemClicked(arg_26_0, arg_26_1)
	arg_26_0.viewParam.episodeId = nil

	TeachNoteModel.instance:setLevelEnterFightState(false)

	arg_26_0._showReward = false
	arg_26_0._delayTime = 0
	arg_26_0._topicId = arg_26_1

	local var_26_0 = TeachNoteModel.instance:getTopicLevelCos(arg_26_0._topicId)
	local var_26_1 = math.floor(0.5 * (#var_26_0 - 1))

	for iter_26_0 = #var_26_0, 1, -1 do
		if not TeachNoteModel.instance:isTeachNoteLevelPass(var_26_0[iter_26_0].id) then
			var_26_1 = math.floor(0.5 * (iter_26_0 - 1))
		end
	end

	TeachNoteModel.instance:setTeachNoticeTopicId(arg_26_0._topicId, var_26_1)
	arg_26_0:_refreshItem()
end

function var_0_0._refreshItem(arg_27_0)
	if arg_27_0._showReward then
		arg_27_0:_refreshReward()
	else
		arg_27_0:_refreshLevel()
	end

	arg_27_0:_refreshTopic()
end

function var_0_0._refreshTopicFinishState(arg_28_0, arg_28_1)
	return TeachNoteModel.instance:getTeachNoteTopicLevelCount(arg_28_1) == TeachNoteModel.instance:getTeachNoteTopicFinishedLevelCount(arg_28_1)
end

function var_0_0._refreshTopic(arg_29_0)
	if arg_29_0._topicItems then
		for iter_29_0, iter_29_1 in pairs(arg_29_0._topicItems) do
			iter_29_1:onDestroyView()
		end
	end

	arg_29_0._topicItems = {}

	local var_29_0 = TeachNoteConfig.instance:getInstructionTopicCos()

	for iter_29_2 = 1, #var_29_0 do
		local var_29_1 = gohelper.cloneInPlace(arg_29_0._gotopicitem)

		gohelper.setActive(var_29_1, true)

		local var_29_2 = TeachNoteTopicListItem.New()

		var_29_2:init(var_29_1, var_29_0[iter_29_2].id, iter_29_2, arg_29_0._showReward, arg_29_0:_refreshTopicFinishState(var_29_0[iter_29_2].id))
		table.insert(arg_29_0._topicItems, var_29_2)
	end

	gohelper.setActive(arg_29_0._gorewardredpoint, TeachNoteModel.instance:hasRewardCouldGet())
end

function var_0_0._onPlayLeftFinishedIn(arg_30_0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_finish)
	arg_30_0._leftpassAni:Play("in", 0, 0)
end

function var_0_0._onPlayRightFinishedIn(arg_31_0)
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_finish)
	arg_31_0._rightpassAni:Play("in", 0, 0)
end

function var_0_0._refreshLevel(arg_32_0)
	gohelper.setActive(arg_32_0._golevel, true)
	gohelper.setActive(arg_32_0._goreward, false)
	gohelper.setActive(arg_32_0._gorewardBeSelected, false)
	gohelper.setActive(arg_32_0._gorewardUnselected, true)

	arg_32_0._topicId, arg_32_0._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	local var_32_0 = TeachNoteModel.instance:getTopicLevelCos(arg_32_0._topicId)
	local var_32_1 = #var_32_0 > 2 and arg_32_0._tag >= math.ceil(0.5 * #var_32_0) - 1 or false

	gohelper.setActive(arg_32_0._btnleftarrow.gameObject, var_32_1)

	local var_32_2 = #var_32_0 > 2 and arg_32_0._tag <= 0 or false

	gohelper.setActive(arg_32_0._btnrightarrow.gameObject, var_32_2)

	local var_32_3 = {
		"bg_jiaoxuebiji_anniudi",
		"bg_jiaoxuebiji_anniudi_1"
	}
	local var_32_4 = {
		"#F7F7F7",
		"#45413E"
	}
	local var_32_5 = var_32_0[2 * arg_32_0._tag + 2]
	local var_32_6 = var_32_0[2 * arg_32_0._tag + 1]

	if var_32_5 then
		gohelper.setActive(arg_32_0._goright, true)
		gohelper.setActive(arg_32_0._goend, false)

		local var_32_7 = TeachNoteModel.instance:isLevelUnlock(var_32_5.id)
		local var_32_8 = var_32_7 and var_32_5.picRes .. ".png" or "bg_jiaoxuebiji_kongdi.png"

		arg_32_0._simagerighticon:LoadImage(ResUrl.getTeachNoteImage(var_32_8))

		local var_32_9 = DungeonConfig.instance:getEpisodeCO(var_32_5.episodeId).chapterId == 1107
		local var_32_10 = var_32_9 and "bg_jiaoxuebiji_bijiben_3.png" or "bg_jiaoxuebiji_bijiben_2.png"

		arg_32_0._simagefyright:LoadImage(ResUrl.getTeachNoteImage(var_32_10))

		local var_32_11 = var_32_9 and arg_32_0._challengeBgRight or arg_32_0._idlebg

		arg_32_0._meshswitch1fyright.texture = var_32_11
		arg_32_0._meshswitch2fyright.texture = var_32_11

		gohelper.setActive(arg_32_0._gorightunlock, var_32_7)
		gohelper.setActive(arg_32_0._gorightlock, not var_32_7)
		gohelper.setActive(arg_32_0._gorightnotetip, var_32_7)

		local var_32_12 = "bg_jiaoxuebiji_shuzi_" .. 2 * arg_32_0._tag + 2

		UISpriteSetMgr.instance:setTeachNoteSprite(arg_32_0._imagerightindex, var_32_12)

		local var_32_13 = TeachNoteConfig.instance:getInstructionLevelCO(var_32_5.id).episodeId
		local var_32_14 = DungeonConfig.instance:getEpisodeCO(var_32_13)

		arg_32_0._txtrightname.text = var_32_14.name
		arg_32_0._txtrightnameen.text = var_32_14.name_En
		arg_32_0._txtrightnotedesc.text = var_32_5.instructionDesc

		local var_32_15 = arg_32_0:_isLevelNewFinished(var_32_5.id)
		local var_32_16 = TeachNoteModel.instance:isTeachNoteLevelPass(var_32_5.id)

		if var_32_16 then
			arg_32_0._rightpassAni.enabled = true

			if var_32_15 then
				arg_32_0._rightunlockAni.enabled = false

				TaskDispatcher.cancelTask(arg_32_0._onPlayRightFinishedIn, arg_32_0)
				TaskDispatcher.runDelay(arg_32_0._onPlayRightFinishedIn, arg_32_0, 0.5)
			else
				arg_32_0._rightpassAni:Play("done", 0, 0)
			end

			local var_32_17 = {}

			if var_32_13 > 0 and not TeachNoteModel.instance:isEpisodeOpen(var_32_13) then
				table.insert(var_32_17, var_32_13)
			end

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(var_32_17)

			arg_32_0._txtrightstartcn.text = luaLang("teachnoteview_restart")
		else
			arg_32_0._rightpassAni.enabled = false

			gohelper.setActive(arg_32_0._gorightpass, false)
			gohelper.setActive(arg_32_0._gorightpassdone, false)

			arg_32_0._rightlockCanvas.alpha = 1
			arg_32_0._txtrightstartcn.text = luaLang("teachnoteview_start")
		end

		if TeachNoteModel.instance:isLevelNewUnlock(var_32_5.id) and not var_32_15 and not var_32_16 then
			AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_unlock)

			local var_32_18 = {}

			if var_32_13 > 0 and not TeachNoteModel.instance:isEpisodeOpen(var_32_13) then
				table.insert(var_32_18, var_32_13)
			end

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(var_32_18)

			arg_32_0._delayTime = arg_32_0._delayTime + 1
			arg_32_0._leftunlockAni.enabled = false
			arg_32_0._rightunlockAni.enabled = true

			arg_32_0._rightunlockAni:Play()
		end

		local var_32_19 = var_32_16 and var_32_3[2] or var_32_3[1]

		UISpriteSetMgr.instance:setTeachNoteSprite(arg_32_0._imagerightlearn, var_32_19)
		SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._txtrightstartcn, var_32_16 and var_32_4[2] or var_32_4[1])
		SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._txtrightstarten, var_32_16 and var_32_4[2] or var_32_4[1])
		ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtrightstarten, 0.5)

		if arg_32_0._rightDescItems then
			for iter_32_0, iter_32_1 in pairs(arg_32_0._rightDescItems) do
				iter_32_1:onDestroyView()
			end
		end

		arg_32_0._rightDescItems = {}

		local var_32_20 = string.split(TeachNoteConfig.instance:getInstructionLevelCO(var_32_5.id).desc, "#")
		local var_32_21

		for iter_32_2 = 1, #var_32_20 do
			local var_32_22 = gohelper.cloneInPlace(arg_32_0._gorightdescitem)

			gohelper.setActive(var_32_22, true)

			local var_32_23 = TeachNoteDescItem.New()

			var_32_23:init(var_32_22, iter_32_2, var_32_5.id)
			table.insert(arg_32_0._rightDescItems, var_32_23)
		end
	else
		local var_32_24 = DungeonConfig.instance:getEpisodeCO(var_32_6.episodeId).chapterId == 1107
		local var_32_25 = var_32_24 and "bg_jiaoxuebiji_bijiben_3.png" or "bg_jiaoxuebiji_bijiben_2.png"

		arg_32_0._simagefyright:LoadImage(ResUrl.getTeachNoteImage(var_32_25))

		local var_32_26 = var_32_24 and arg_32_0._challengeBgRight or arg_32_0._idlebg

		arg_32_0._meshswitch1fyright.texture = var_32_26
		arg_32_0._meshswitch2fyright.texture = var_32_26

		gohelper.setActive(arg_32_0._goright, false)
		gohelper.setActive(arg_32_0._goend, true)
	end

	if var_32_6 then
		gohelper.setActive(arg_32_0._goleft, true)

		local var_32_27 = TeachNoteModel.instance:isLevelUnlock(var_32_6.id)
		local var_32_28 = var_32_27 and var_32_6.picRes .. ".png" or "bg_jiaoxuebiji_kongdi.png"

		arg_32_0._simagelefticon:LoadImage(ResUrl.getTeachNoteImage(var_32_28))

		local var_32_29 = DungeonConfig.instance:getEpisodeCO(var_32_6.episodeId).chapterId == 1107
		local var_32_30 = var_32_29 and "bg_jiaoxuebiji_bijiben_4.png" or "bg_jiaoxuebiji_bijiben_2_1.png"

		arg_32_0._simagefyleft:LoadImage(ResUrl.getTeachNoteImage(var_32_30))

		local var_32_31 = var_32_29 and arg_32_0._challengeBgLeft or arg_32_0._normalBgLeft

		arg_32_0._meshswitch1fyleft.texture = var_32_31
		arg_32_0._meshswitch2fyleft.texture = var_32_31

		gohelper.setActive(arg_32_0._goleftunlock, var_32_27)
		gohelper.setActive(arg_32_0._goleftlock, not var_32_27)
		gohelper.setActive(arg_32_0._goleftnotetip, var_32_27)

		local var_32_32 = "bg_jiaoxuebiji_shuzi_" .. 2 * arg_32_0._tag + 1

		UISpriteSetMgr.instance:setTeachNoteSprite(arg_32_0._imageleftindex, var_32_32)

		local var_32_33 = TeachNoteConfig.instance:getInstructionLevelCO(var_32_6.id).episodeId
		local var_32_34 = DungeonConfig.instance:getEpisodeCO(var_32_33)

		arg_32_0._txtleftname.text = var_32_34.name
		arg_32_0._txtleftnameen.text = var_32_34.name_En
		arg_32_0._txtleftnotedesc.text = var_32_6.instructionDesc

		local var_32_35 = arg_32_0:_isLevelNewFinished(var_32_6.id)
		local var_32_36 = TeachNoteModel.instance:isTeachNoteLevelPass(var_32_6.id)

		if var_32_36 then
			arg_32_0._leftpassAni.enabled = true

			if var_32_35 then
				TaskDispatcher.cancelTask(arg_32_0._onPlayLeftFinishedIn, arg_32_0)
				TaskDispatcher.runDelay(arg_32_0._onPlayLeftFinishedIn, arg_32_0, 0.5)
			else
				arg_32_0._leftpassAni:Play("done", 0, 0)
			end

			local var_32_37 = {}

			if var_32_33 > 0 and not TeachNoteModel.instance:isEpisodeOpen(var_32_33) then
				table.insert(var_32_37, var_32_33)
			end

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(var_32_37)

			arg_32_0._txtleftstartcn.text = luaLang("teachnoteview_restart")
		else
			arg_32_0._leftpassAni.enabled = false

			gohelper.setActive(arg_32_0._goleftpass, false)
			gohelper.setActive(arg_32_0._goleftpassdone, false)

			arg_32_0._leftlockCanvas.alpha = 1
			arg_32_0._txtleftstartcn.text = luaLang("teachnoteview_start")
		end

		if TeachNoteModel.instance:isLevelNewUnlock(var_32_6.id) and not var_32_35 and not arg_32_0._rightunlockAni.isPlaying and not var_32_36 then
			AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_level_unlock)

			local var_32_38 = {}

			if var_32_33 > 0 and not TeachNoteModel.instance:isEpisodeOpen(var_32_33) then
				table.insert(var_32_38, var_32_33)
			end

			arg_32_0._delayTime = arg_32_0._delayTime + 1

			DungeonRpc.instance:sendInstructionDungeonOpenRequest(var_32_38)

			arg_32_0._leftunlockAni.enabled = true
			arg_32_0._rightunlockAni.enabled = false

			arg_32_0._leftunlockAni:Play()
		end

		local var_32_39 = var_32_36 and var_32_3[2] or var_32_3[1]

		UISpriteSetMgr.instance:setTeachNoteSprite(arg_32_0._imageleftlearn, var_32_39)
		SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._txtleftstartcn, var_32_36 and var_32_4[2] or var_32_4[1])
		SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._txtleftstarten, var_32_36 and var_32_4[2] or var_32_4[1])
		ZProj.UGUIHelper.SetColorAlpha(arg_32_0._txtleftstarten, 0.5)

		if arg_32_0._leftDescItems then
			for iter_32_3, iter_32_4 in pairs(arg_32_0._leftDescItems) do
				iter_32_4:onDestroyView()
			end
		end

		arg_32_0._leftDescItems = {}

		local var_32_40
		local var_32_41 = string.split(TeachNoteConfig.instance:getInstructionLevelCO(var_32_6.id).desc, "#")

		for iter_32_5 = 1, #var_32_41 do
			local var_32_42 = gohelper.cloneInPlace(arg_32_0._goleftdescitem)

			gohelper.setActive(var_32_42, true)

			local var_32_43 = TeachNoteDescItem.New()

			var_32_43:init(var_32_42, iter_32_5, var_32_6.id)
			table.insert(arg_32_0._leftDescItems, var_32_43)
		end
	else
		arg_32_0._simagefyleft:LoadImage(ResUrl.getTeachNoteImage("bg_jiaoxuebiji_bijiben_2_1.png"))

		arg_32_0._meshswitch1fyleft.texture = arg_32_0._normalBgLeft
		arg_32_0._meshswitch2fyleft.texture = arg_32_0._normalBgLeft

		gohelper.setActive(arg_32_0._goleft, false)
	end

	TaskDispatcher.cancelTask(arg_32_0.endBlock, arg_32_0)
	TaskDispatcher.runDelay(arg_32_0.endBlock, arg_32_0, arg_32_0._delayTime)
end

function var_0_0._setLearnBtnColor(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_2 and "#45413E" or "#F7F7F7"

	SLFramework.UGUI.GuiHelper.SetColor(arg_33_1, var_33_0)
end

function var_0_0._isLevelNewFinished(arg_34_0, arg_34_1)
	if TeachNoteModel.instance:isFinishLevelEnterFight() then
		return false
	end

	if not arg_34_0.viewParam.episodeId then
		return false
	end

	local var_34_0 = TeachNoteConfig.instance:getInstructionLevelCO(arg_34_1).episodeId

	if arg_34_0.viewParam.episodeId == var_34_0 and not TeachNoteModel.instance:isTeachNoteLevelPass(arg_34_1) and not arg_34_0._showFinished then
		arg_34_0._showFinished = true

		return true
	end

	return false
end

function var_0_0._refreshReward(arg_35_0)
	arg_35_0:endBlock()
	gohelper.setActive(arg_35_0._golevel, false)
	gohelper.setActive(arg_35_0._goreward, true)
	gohelper.setActive(arg_35_0._gorewardBeSelected, true)
	gohelper.setActive(arg_35_0._gorewardUnselected, false)

	local var_35_0 = TeachNoteConfig.instance:getInstructionTopicCos()

	TeachNoteRewardListModel.instance:setRewardList(var_35_0)
	arg_35_0:_refreshFinishItem()
end

function var_0_0._changeLeft(arg_36_0)
	arg_36_0._topicId, arg_36_0._tag = TeachNoteModel.instance:getTeachNoticeTopicId()

	local var_36_0 = TeachNoteModel.instance:getTopicLevelCos(arg_36_0._topicId)

	if arg_36_0._tag >= math.ceil(0.5 * #var_36_0) - 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	arg_36_0._viewAnim.enabled = true

	arg_36_0._viewAnim:Play("fanye02", 0, 0)

	arg_36_0._tag = arg_36_0._tag + 1

	TeachNoteModel.instance:setTeachNoticeTopicId(arg_36_0._topicId, arg_36_0._tag)
	TaskDispatcher.cancelTask(arg_36_0._refreshLevel, arg_36_0)
	TaskDispatcher.runDelay(arg_36_0._refreshLevel, arg_36_0, 0.3)
end

function var_0_0._changeRight(arg_37_0)
	if arg_37_0._tag < 1 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_feedback_open)

	arg_37_0._viewAnim.enabled = true

	arg_37_0._viewAnim:Play("fanye01", 0, 0)

	arg_37_0._tag = arg_37_0._tag - 1

	TeachNoteModel.instance:setTeachNoticeTopicId(arg_37_0._topicId, arg_37_0._tag)
	TaskDispatcher.cancelTask(arg_37_0._refreshLevel, arg_37_0)
	TaskDispatcher.runDelay(arg_37_0._refreshLevel, arg_37_0, 0.3)
end

function var_0_0.onDestroyView(arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._onPlayLeftFinishedIn, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._onPlayRightFinishedIn, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._refreshLevel, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0.endBlock, arg_38_0)
	TaskDispatcher.cancelTask(arg_38_0._playBackTeachNote, arg_38_0)

	if arg_38_0._textureLoader then
		arg_38_0._textureLoader:dispose()

		arg_38_0._textureLoader = nil
	end

	arg_38_0._simagebg:UnLoadImage()
	arg_38_0._simagefyright:UnLoadImage()
	arg_38_0._simagefyleft:UnLoadImage()
	arg_38_0._simagelefticon:UnLoadImage()
	arg_38_0._simagerighticon:UnLoadImage()
	arg_38_0._simagerewardbg1:UnLoadImage()
	arg_38_0._simagelefunlock:UnLoadImage()
	arg_38_0._simagerightunlock:UnLoadImage()
	arg_38_0._simageleftlockmask:UnLoadImage()
	arg_38_0._simagerightlockmask:UnLoadImage()

	if arg_38_0._topicItems then
		for iter_38_0, iter_38_1 in pairs(arg_38_0._topicItems) do
			iter_38_1:onDestroyView()
		end

		arg_38_0._topicItems = nil
	end

	if arg_38_0._leftDescItems then
		for iter_38_2, iter_38_3 in pairs(arg_38_0._leftDescItems) do
			iter_38_3:onDestroyView()
		end

		arg_38_0._leftDescItems = nil
	end

	if arg_38_0._rightDescItems then
		for iter_38_4, iter_38_5 in pairs(arg_38_0._rightDescItems) do
			iter_38_5:onDestroyView()
		end

		arg_38_0._rightDescItems = nil
	end

	if arg_38_0._rewardIcons then
		for iter_38_6, iter_38_7 in pairs(arg_38_0._rewardIcons) do
			gohelper.destroy(iter_38_7.go)
			iter_38_7.icon:onDestroy()
		end

		arg_38_0._rewardIcons = nil
	end
end

return var_0_0
