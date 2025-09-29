from sqlalchemy.orm import Session
from app.domains.user.models import User

def create_user(db: Session, user: User):
    db.add(user)
    db.commit()
    db.refresh(user)
    return user
