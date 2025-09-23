from fastapi import FastAPI
from app.core.db_config import Base, engine
from app.signup.routes import router as signup_router

Base.metadata.create_all(bind=engine)

app = FastAPI()
app.include_router(signup_router)
