module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazePawnObj", package.seeall)

slot0 = class("PuzzleMazePawnObj", PuzzleMazeBasePawnObj)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0.image = gohelper.findChildImage(slot0.go, "#go_ctrl/#image_content")
	slot0.imageTf = slot0.image.transform
	slot0.goCtrl = gohelper.findChild(slot0.go, "#go_ctrl")
	slot0.tf = slot0.go.transform
	slot0.dir = PuzzleEnum.dir.left
	slot0.anim = slot0.image.gameObject:GetComponent(typeof(UnityEngine.Animator))
	slot0.animEvent = slot0.image.gameObject:GetComponent(typeof(ZProj.AnimationEventWrap))

	slot0.animEvent:AddEventListener(PuzzleEnum.AnimEvent_OnJump, slot0.onPawnJump, slot0)
end

function slot0.onInit(slot0, slot1, slot2)
	slot0.anim:Play("open")
	UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(slot0.image, PuzzleMazeDrawModel.instance:pawnIconUrl(), true)
	recthelper.setAnchor(slot0.goCtrl.transform, PuzzleEnum.MazeMonsterIconOffset.x, PuzzleEnum.MazeMonsterIconOffset.y)
	slot0:setPos(slot1, slot2)
	gohelper.setAsLastSibling(slot0.go)
end

function slot0.onBeginDrag(slot0)
	slot0.anim:Play("image_content_drag")
end

function slot0.onDraging(slot0, slot1, slot2)
	uv0.super.onDraging(slot0, slot1, slot2)
end

function slot0.onEndDrag(slot0, slot1, slot2)
	uv0.super.onEndDrag(slot0, slot1, slot2)
	slot0.anim:Play("open")
end

function slot0.setPos(slot0, slot1, slot2)
	uv0.super.setPos(slot0, slot1, slot2)
	recthelper.setAnchor(slot0.tf, slot1, slot2)
end

function slot0.setDir(slot0, slot1)
	slot0.dir = slot1

	transformhelper.setLocalRotation(slot0.tf, 0, slot1 == PuzzleEnum.dir.right and 180 or 0, 0)
end

function slot0.onPawnJump(slot0)
	AudioMgr.instance:trigger(AudioEnum.Puzzle.play_ui_main_puzzles_move)
end

function slot0.destroy(slot0)
	slot0.animEvent:RemoveEventListener(PuzzleEnum.AnimEvent_OnJump)
	uv0.super.destroy(slot0)
end

return slot0
