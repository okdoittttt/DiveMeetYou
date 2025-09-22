from fastapi import APIRouter, Depends, Form
from sqlalchemy.orm import Session
from app.core.db_config import get_db
from app.domains.user.crud import create_user

router = APIRouter(prefix="/signup", tags=["Signup"])

@router.post("/signup")
def signup(
    email: str = Form(...),
    password: str = Form(...),
    nickname: str = Form(...),
    profile_image_url: str = Form("https://yourdomain.com/default-profile.png"),
    db: Session = Depends(get_db)
):
    user_data = {
        "email": email,
        "password": password,
        "nickname": nickname,
        "profile_image_url": profile_image_url
    }
    user = create_user(db, user_data)
    return {"message": "회원가입 성공", "email": user.email}
