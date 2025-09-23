from sqlalchemy import Column, String, DateTime
from sqlalchemy.sql import func
from app.core.db_config import Base

class User(Base):
    __tablename__ = "users"

    email = Column(String(255), primary_key=True, index=True)
    password = Column(String(255), nullable=False)
    nickname = Column(String(100), nullable=False)
    profile_image_url = Column(String, default="https://yourdomain.com/default-profile.png")
    created_at = Column(DateTime(timezone=True), server_default=func.now())
