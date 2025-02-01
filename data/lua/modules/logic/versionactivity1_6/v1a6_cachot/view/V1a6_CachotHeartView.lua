module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeartView", package.seeall)

slot0 = class("V1a6_CachotHeartView", BaseView)

function slot0.ctor(slot0, slot1)
	slot0._rootPath = slot1 or ""

	uv0.super.ctor(slot0)
end

function slot0.onInitView(slot0)
	slot0._rootGo = gohelper.findChild(slot0.viewGO, slot0._rootPath)

	gohelper.setActive(slot0._rootGo, true)

	slot0._gotipsbg = gohelper.findChild(slot0._rootGo, "#go_tipsbg")
	slot0._txttitle = gohelper.findChildTextMesh(slot0._rootGo, "#go_tipsbg/title")
	slot0._gotipsitem = gohelper.findChild(slot0._rootGo, "#go_tipsbg/nowDes/#go_tipsitem")
	slot0._btnheartclick = gohelper.findChildButtonWithAudio(slot0._rootGo, "#btn_heartclick")
	slot0._slider = gohelper.findChildSlider(slot0._rootGo, "#slider_heart")
	slot0._txtnum = gohelper.findChildTextMesh(slot0._rootGo, "#slider_heart/Handle Slide Area/Handle/#txt_num")
	slot0._imagelight = gohelper.findChildImage(slot0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light")
	slot0._golighteffectyellow = gohelper.findChild(slot0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/yellow")
	slot0._golighteffectorange = gohelper.findChild(slot0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/orange")
	slot0._golighteffectblue = gohelper.findChild(slot0._rootGo, "#slider_heart/Handle Slide Area/Handle/#image_light/blue")
	slot0._gonexttitle = gohelper.findChild(slot0._rootGo, "#go_tipsbg/nextTitle")
	slot0._txtnextNum = gohelper.findChildTextMesh(slot0._rootGo, "#go_tipsbg/nextTitle/nextNum")
	slot0._gonextDes = gohelper.findChild(slot0._rootGo, "#go_tipsbg/nextDes")
	slot0._gonextDesItem = gohelper.findChild(slot0._rootGo, "#go_tipsbg/nextDes/#go_tipsitem")
	slot0._gopretitle = gohelper.findChild(slot0._rootGo, "#go_tipsbg/preTitle")
	slot0._txtpreNum = gohelper.findChildTextMesh(slot0._rootGo, "#go_tipsbg/preTitle/preNum")
	slot0._gopreDes = gohelper.findChild(slot0._rootGo, "#go_tipsbg/preDes")
	slot0._gopreDesItem = gohelper.findChild(slot0._rootGo, "#go_tipsbg/preDes/#go_tipsitem")
end

function slot0.addEvents(slot0)
	slot0._btnheartclick:AddClickListener(slot0.showHideTips, slot0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._refreshInfo, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateHeart, slot0._refreshInfo, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnheartclick:RemoveClickListener()
	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreen, slot0._onTouchScreen, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0._refreshInfo, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateHeart, slot0._refreshInfo, slot0)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._golighteffectyellow, false)
	gohelper.setActive(slot0._golighteffectorange, false)
	gohelper.setActive(slot0._golighteffectblue, false)
	slot0:_refreshInfo(true)
end

function slot0._refreshInfo(slot0, slot1)
	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not slot0._rogueInfo then
		return
	end

	slot0._txttitle.text = V1a6_CachotConfig.instance:getHeartConfig(slot0._rogueInfo.heart).title

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot1 or not slot0._nowHeart then
		slot0:_setValue(slot2, true)

		slot0._nowHeart = slot2
	elseif slot0._nowHeart ~= slot2 then
		slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(slot0._nowHeart, slot2, 0.5, slot0._setValue, slot0._onTweenHeartFinish, slot0)
	end

	gohelper.CreateObjList(slot0, slot0.onDesItemCreate, slot0:_getDesData(slot3.desc), slot0._gotipsitem.transform.parent.gameObject, slot0._gotipsitem)

	slot6 = lua_rogue_heartbeat.configDict[slot3.id + 1]

	if lua_rogue_heartbeat.configDict[slot3.id - 1] then
		slot0._txtpreNum.text = formatLuaLang("v1a6_cachot_heart_lt", string.splitToNumber(slot5.range, "#")[2])

		gohelper.setActive(slot0._gopretitle, true)
		gohelper.setActive(slot0._gopreDes, true)
		gohelper.CreateObjList(slot0, slot0.onDesItemCreate, slot0:_getDesData(slot5.desc), slot0._gopreDesItem.transform.parent.gameObject, slot0._gopreDesItem)
	else
		gohelper.setActive(slot0._gopretitle, false)
		gohelper.setActive(slot0._gopreDes, false)
	end

	if slot6 then
		slot0._txtnextNum.text = formatLuaLang("v1a6_cachot_heart_gt", string.splitToNumber(slot6.range, "#")[1])

		gohelper.setActive(slot0._gonexttitle, true)
		gohelper.setActive(slot0._gonextDes, true)
		gohelper.CreateObjList(slot0, slot0.onDesItemCreate, slot0:_getDesData(slot6.desc), slot0._gonextDesItem.transform.parent.gameObject, slot0._gonextDesItem)
	else
		gohelper.setActive(slot0._gonexttitle, false)
		gohelper.setActive(slot0._gonextDes, false)
	end
end

function slot0._getDesData(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		slot2 = string.split(slot1, "\n")
	end

	return slot2
end

function slot0._onTweenHeartFinish(slot0)
	slot0._tweenId = nil
end

function slot0._setValue(slot0, slot1, slot2)
	slot1 = math.floor(slot1)
	slot5 = string.splitToNumber(lua_rogue_const.configDict[V1a6_CachotEnum.Const.HeartConst].value, "#")
	slot0._txtnum.text = slot1

	slot0._slider:SetValue((slot1 - slot5[1]) / (slot5[2] - slot5[1]))

	slot6, slot7 = nil

	if V1a6_CachotConfig.instance:getHeartConfig(slot1).id < slot5[3] then
		slot6 = "v1a6_cachot_img_heartblue"
		slot7 = slot0._golighteffectblue
	elseif slot5[3] == slot3.id then
		slot6 = "v1a6_cachot_img_heartyellow"
		slot7 = slot0._golighteffectyellow
	elseif slot5[3] < slot3.id then
		slot6 = "v1a6_cachot_img_heartorange"
		slot7 = slot0._golighteffectorange
	end

	if not slot2 and slot0._nowIcon ~= slot6 then
		gohelper.setActive(slot7, false)
		gohelper.setActive(slot7, true)
	end

	slot0._nowIcon = slot6
	slot0._nowHeart = slot1

	UISpriteSetMgr.instance:setV1a6CachotSprite(slot0._imagelight, slot6)
end

function slot0.onDesItemCreate(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "desc").text = slot2
end

function slot0._onTouchScreen(slot0)
	if gohelper.isMouseOverGo(slot0._btnheartclick) then
		return
	end

	gohelper.setActive(slot0._gotipsbg, false)
end

function slot0.showHideTips(slot0)
	gohelper.setActive(slot0._gotipsbg, not slot0._gotipsbg.activeSelf)
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId, false)

		slot0._tweenId = nil
	end
end

return slot0
