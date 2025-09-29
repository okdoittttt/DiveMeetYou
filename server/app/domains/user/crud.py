from sqlalchemy.orm import Session
from app.domains.user.models import User

def create_user(db: Session, user_instance: User):
    # user = User(**user_data)
    db.add(user)
    db.commit()
    db.refresh(user)
    return user
